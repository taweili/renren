module Renren
  class Photo < Model
    
    def self.elm_name
      "photo"
    end
    
    def self.attr_names
      [
       :pid,
       :aid,
       :uid,
       :url_head,
       :url_large,
       :caption,
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
