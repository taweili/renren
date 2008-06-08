module Xiaonei
  class User
    ATTR_SYMS = [ :uid,
                  :name,
                  :sex,
                  :birthday,
                  :tinyurl,
                  :headurl,
                  :mainurl,
                  :hometown_location,
                  :country,
                  :province,
                  :city,
                  :work_history,
                  :work_info,
                  :company_name,
                  :description,
                  :start_date,
                  :end_date,
                  :university_history,
                  :university_info,
                  :name,
                  :year,
                  :department,
                  :hs_history,
                  :hs_info,
                  :name,
                  :grad_year,
                  :contact_info,
                  :msn,
                  :mobile_tel,
                  :telephone,
                  :web_site,
                  :books,
                  :movies,
                  :music ]
    
    for a in ATTR_SYMS
      attr_accessor a
    end
    
    def has_attr?(attr)
      ATTR_SYMS.include?(attr.to_sym)
    end

  end
end
