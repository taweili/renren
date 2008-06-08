module Xiaonei
  class HometownLocation < Model
    
    def self.elm_name
      "hometown_location"
    end
    
    def self.attr_names
      [ :country, :province, :city ]
    end
    
    for a in attr_names
      attr_accessor a
    end

  end
end
