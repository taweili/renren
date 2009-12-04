require 'net/http'
require 'pp'
module Xiaonei
  class Service
    DEBUG = false

    def post(params)
      pp "### Posting Params: #{params.inspect}" if DEBUG
      Net::HTTP.post_form(url, params)
    end

    private

    def url
      URI.parse('http://api.xiaonei.com/restserver.do')
    end
  end
end
