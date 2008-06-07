require 'net/http'

module Xiaonei
  class Service

    def post(params)
      Net::HTTP.post_form(url, params)
    end
    
    private
    def url
      URI.parse('http://api.xiaonei.com/restserver.do')
    end
  end
end
