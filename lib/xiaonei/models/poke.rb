module Xiaonei
  class Poke < Model
    
    def self.elm_name
      "poke"
    end
    
    def self.attr_names
      [
       :uid,
       :name,
       :time,
       :id
      ]
    end

    for a in attr_names
      attr_accessor a
    end
    
  end
end
