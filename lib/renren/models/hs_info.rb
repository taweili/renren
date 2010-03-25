module Renren
  class HsInfo < Model
    
    def self.elm_name
      "hs_info"
    end
    
    def self.attr_names
      [:name, 
       :grad_year]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
