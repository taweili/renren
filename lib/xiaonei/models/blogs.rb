module Xiaonei
  class Blogs < Model
    
    def self.elm_name
      "blog_gets_response"
    end
    
    def self.attr_names
      [
       :uid,
       :name,
       :total
      ]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
