require 'sinatra'

module FaviconFinder
  class Api < Sinatra::Base

    get '/' do
      erb :index, :locals => {:domain => nil, :fav_url => nil}
    end

    post '/' do
      domain = UrlCleaner.clean_domain(params[:domain])
      favicon = get_favicon_for_url(domain)
      if favicon
        erb :index, :locals => {:domain => domain, :fav_url => favicon.fav_url}
      else
        erb :index, :locals => {:domain => domain, :fav_url => nil}
      end
    end

    def get_favicon_for_url(domain, is_fresh = false)
      if is_fresh
        Favicon.retrieve_and_persist(domain)
      else
        if favicon = Favicon[:url => domain]
          favicon
        else
          Favicon.retrieve_and_persist(domain)
        end
      end
    end


  end
end
