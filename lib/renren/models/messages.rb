module Renren
  class Messages < Model
    
    def self.elm_name
      "message_gets_response"
    end
    
    def self.attr_names
      [
       :unread_count,
       :count,
       :end_date
      ]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
