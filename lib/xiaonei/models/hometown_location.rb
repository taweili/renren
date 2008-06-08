module Xiaonei
  class HometownLocation
    ATTR_SYMS = [ :country, :province, :city ]
    
    for a in ATTR_SYMS
      attr_accessor a
    end
    
    def has_attr?(attr)
      ATTR_SYMS.include?(attr.to_sym)
    end

  end
end
