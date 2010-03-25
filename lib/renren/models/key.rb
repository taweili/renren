module Renren
  class Key < Model
    
    def self.elm_name
      "auth_getSession_response"
    end
    
    def self.attr_names
      [
       :session_key,
       :uid
      ]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
