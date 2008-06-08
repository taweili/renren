module Xiaonei
  class ContactInfo < Model
    
    def self.elm_name
      "contact_info"
    end
    
    def self.attr_names
      [
       :msn,
       :mobile_tel,
       :telephone,
       :web_site
      ]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
