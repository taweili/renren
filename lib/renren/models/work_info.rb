module Renren
  class WorkInfo < Model
    
    def self.elm_name
      "work_info"
    end
    
    def self.attr_names
      [:company_name, 
       :description,
       :start_date,
       :end_date]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
