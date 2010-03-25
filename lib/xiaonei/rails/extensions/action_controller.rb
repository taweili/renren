module ::ActionController
  class Base
    def self.inherited_with_xiaonei(subclass)
      inherited_without_xiaonei(subclass)
      if subclass.to_s == "ApplicationController"
        subclass.send(:include, Xiaonei::Rails::Controller) 
        subclass.helper Xiaonei::Rails::Helpers
      end
    end
    class << self
      alias_method_chain :inherited, :xiaonei
    end
  end
end