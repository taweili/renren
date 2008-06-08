module Xiaonei
  class Friend < Model
    
    def self.elm_name
      "friend"
    end
    
    def self.attr_names
      [
       :id,
       :name,
       :headurl,
       :network_id, 
       :network_name
      ]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
