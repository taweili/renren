
module Xiaonei
  class Model
    def has_attr?(attr)
      self.attr_names.include?(attr.to_sym)
    end
    
    def self.is_array?
      false
    end
  end
end
