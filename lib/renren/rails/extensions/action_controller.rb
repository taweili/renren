module ::ActionController
  class Base
    def self.inherited_with_renren(subclass)
      inherited_without_renren(subclass)
      if subclass.to_s == "ApplicationController"
        subclass.send(:include, Renren::Rails::Controller) 
        subclass.helper Renren::Rails::Helpers
      end
    end
    class << self
      alias_method_chain :inherited, :renren
    end
  end
end