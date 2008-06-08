module Xiaonei
  class WorkInfo
    ATTR_SYMS = [:company_name, 
                 :description,
                 :start_date,
                 :end_date]

    for a in ATTR_SYMS
      attr_accessor a
    end
    
    def has_attr?(attr)
      ATTR_SYMS.include?(attr.to_sym)
    end

  end
end
