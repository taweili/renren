class RenrenGenerator < Rails::Generator::Base
  def manifest
    record do |m|
      m.file 'config/renren.yml', 'config/renren.yml'
      m.file "public/xd_receiver.html", "public/xd_receiver.html"
    end
  end
end
