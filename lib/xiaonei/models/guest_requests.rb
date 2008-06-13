module Xiaonei
  class GuestRequests < Array
    
    def self.elm_name
      "requests_getGuestRequests_response"
    end
    
    def self.attr_names
      [
       :total
      ]
    end

    def self.is_array?
      true
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
