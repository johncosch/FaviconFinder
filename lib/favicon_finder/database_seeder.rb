require "thread"

module FaviconFinder
  class DatabaseSeeder
    POOL_SIZE = 10
    COUNT_LIMIT = 100

    #
    # => Right now I'm flooding memory with all of the urls. I could attempt to process them in a seperate thread
    # => so the entire list would not be in memory at the same time.
    #

    def seed
      @queue = Queue.new
      count = 0
      File.foreach(File.join(Dir.getwd, 'top-1m.csv')) do |line|
        break if count >= COUNT_LIMIT
        line_components = line.split(",")
        domain = "http://" + line_components.last
        @queue.push domain
        count += 1
      end
      process_urls
    end

    private

    def process_urls
      workers = (POOL_SIZE).times.map do
        Thread.new do
          begin
            while domain = @queue.pop(true)
              Favicon.retrieve_and_persist(domain)
            end
          rescue ThreadError => e
            puts e
          end
        end
      end
      workers.map(&:join)
    end

  end
end
