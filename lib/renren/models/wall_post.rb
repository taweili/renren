module Renren
  class WallPost < Model
    
    def self.elm_name
      "wall_addPost_response"
    end
    
    def self.attr_names
      [
       :id
      ]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
