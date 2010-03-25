module Renren
  class UniversityInfo < Model
    
    def self.elm_name
      "university_info"
    end
    
    def self.attr_names
      [:name, 
       :year,
       :department]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
