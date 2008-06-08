module Xiaonei
  class User < Model
    def self.elm_name
      "user"
    end
    
    def self.attr_names
      [ :uid,
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
    end
    
    for a in attr_names
      attr_accessor a
    end
    
  end
end
