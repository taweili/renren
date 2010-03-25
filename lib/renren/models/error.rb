require 'renren/model'

module Renren
  class Error < Model
    
    def self.elm_name
      "error_response"
    end
    
    def self.attr_names
      [:error_code, :error_msg]
    end
    
    for a in attr_names
      attr_accessor a
    end
    
    def code
      @error_code
    end

    def msg
      @error_msg
    end
  end
end
