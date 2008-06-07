module Xiaonei
  class Session
    attr_accessor :auth_token
    attr_accessor :session_key
    
    def api_key
      ENV['XIAONEI_API_KEY']
    end
    
    def invoke_method(method, params = {})
      xn_params = { 
        :method => method,
        :api_key => api_key,
        :session_key => session_key,
        :v => "1.0" }
      xn_params.merge!(params) if params
      parse(Service.new.post(xn_params).data)
    end
    
    def parse(data)
      parser = REXML::SAX2Parser.new(data)
    end
  end
end
