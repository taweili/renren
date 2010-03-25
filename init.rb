xiaonei_config = "#{RAILS_ROOT}/config/renren.yml"

require 'xiaonei'
require "xiaonei/rails/controller"
require "xiaonei/rails/helpers"
require "xiaonei/rails/extensions/action_controller"
require "xiaonei/rails/xiaonei_url_rewrite"
require "xiaonei/session"

if File.exist?(xiaonei_config)
  XIAONEI = YAML.load_file(xiaonei_config)[RAILS_ENV] 
  ENV['XIAONEI_API_KEY'] = XIAONEI['api_key']
  ENV['XIAONEI_SECRET_KEY'] = XIAONEI['secret_key']
  ENV['XIAONEI_RELATIVE_URL_ROOT'] = XIAONEI['canvas_page_name']
  ActionController::Base.asset_host = XIAONEI['callback_url']
end

ActionController::Base.send(:include,Xiaonei::Rails::Controller) 

class ActionController::Routing::Route
  def recognition_conditions_with_xiaonei
    defaults = recognition_conditions_without_xiaonei 
    defaults << " env[:canvas] == conditions[:canvas] " if conditions[:canvas]
    defaults
  end
  alias_method_chain :recognition_conditions, :xiaonei
end

# We turn off route optimization to make named routes use our code for figuring out if they should go to the session
# If this fails, it means we're on rails 1.2, we can ignore it
begin
  ActionController::Base::optimise_named_routes = false 
rescue NoMethodError=>e
  nil
end

# pull :canvas=> into env in routing to allow for conditions
ActionController::Routing::RouteSet.send :include,  Xiaonei::Rails::Routing::RouteSetExtensions
ActionController::Routing::RouteSet::Mapper.send :include, Xiaonei::Rails::Routing::MapperExtensions
