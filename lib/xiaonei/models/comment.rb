module Xiaonei
  class Comment < Model
    
    def self.elm_name
      "comment"
    end
    
    def self.attr_names
      [
       :id,
       :uid,
       :name,
       :time,
       :tinyurl,
       :text
      ]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
