class RenrenGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file 'config/renren.yml', 'config/renren.yml'
    end
  end
end
