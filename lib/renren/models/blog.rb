module Renren
  class Blog < Model
    
    def self.elm_name
      "blog"
    end
    
    def self.attr_names
      [
       :id,
       :title,
       :time,
       :view_count,
       :comment_count
      ]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
