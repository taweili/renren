module Xiaonei
  class Guest < Model
    
    def self.elm_name
      "guest"
    end
    
    def self.attr_names
      [
       :headurl,
       :uid,
       :name,
       :network
      ]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
