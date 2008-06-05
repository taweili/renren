require 'net/http'

module Xiaonei
  class Service
    def initialize(api_key)
      @api_key = api_key
    end
    
    def post(params)
      Net::HTTP.post_form(url, params)
    end
    
    def post_file(params)
      Net::HTTP.post_multipart_form(url, params)
    end
    
    private
    def url
      URI.parse('http://api.xiaonei.com/restserver.do')
    end
  end
end
