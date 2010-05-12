module Renren
  class Admin < Model
    def self.elm_name
      "admin_getAllocation_response"
    end
    
    def self.attr_names
      [ :notifications_per_day,
        :requests_per_day ]
    end
    
    for a in attr_names
      attr_accessor a
    end
    
  end
end
