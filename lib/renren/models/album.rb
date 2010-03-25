module Renren
  class Album < Model
    
    def self.elm_name
      "album"
    end
    
    def self.attr_names
      [
       :aid,
       :uid,
       :url,
       :name,
       :size,
       :create_time,
       :update_time
      ]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
