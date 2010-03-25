module Renren
  class WallPosts < Model
    
    def self.elm_name
      "wall_getPosts_response"
    end
    
    def self.attr_names
      [
       :uid,
       :name,
       :total,
       :comments
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
