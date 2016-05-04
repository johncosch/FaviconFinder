require "thread"
require "concurrent"

module FaviconFinder
  class DatabaseSeeder
    POOL_SIZE = 50
    COUNT_LIMIT = 1000

    def seed
      @queue = Queue.new
      count = 0
      File.foreach(File.join(Dir.getwd, 'top-1m.csv')) do |line|
        break if count >= COUNT_LIMIT
        line_components = line.split(",")
        domain = UrlCleaner.clean_domain(line_components.last)
        @queue.push domain
        count += 1
      end
      process_urls
    end

    private

    def process_urls
      incrementor = Concurrent::AtomicFixnum.new
      workers = (POOL_SIZE).times.map do
        Thread.new do
          begin
            while domain = @queue.pop(true)
              incrementor.increment
              puts "#{incrementor.value}: #{domain}"
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
