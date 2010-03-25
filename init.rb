renren_config = "#{RAILS_ROOT}/config/renren.yml"

require 'renren'
require "renren/rails/controller"
require "renren/rails/helpers"
require "renren/rails/extensions/action_controller"
require "renren/rails/renren_url_rewrite"
require "renren/session"

if File.exist?(renren_config)
  RENREN = YAML.load_file(renren_config)[RAILS_ENV] 
  ENV['RENREN_API_KEY'] = RENREN['api_key']
  ENV['RENREN_SECRET_KEY'] = RENREN['secret_key']
  ENV['RENREN_RELATIVE_URL_ROOT'] = RENREN['canvas_page_name']
  ActionController::Base.asset_host = RENREN['callback_url']
end

ActionController::Base.send(:include,Renren::Rails::Controller) 

class ActionController::Routing::Route
  def recognition_conditions_with_renren
    defaults = recognition_conditions_without_renren 
    defaults << " env[:canvas] == conditions[:canvas] " if conditions[:canvas]
    defaults
  end
  alias_method_chain :recognition_conditions, :renren
end

# We turn off route optimization to make named routes use our code for figuring out if they should go to the session
# If this fails, it means we're on rails 1.2, we can ignore it
begin
  ActionController::Base::optimise_named_routes = false 
rescue NoMethodError=>e
  nil
end

# pull :canvas=> into env in routing to allow for conditions
ActionController::Routing::RouteSet.send :include,  Renren::Rails::Routing::RouteSetExtensions
ActionController::Routing::RouteSet::Mapper.send :include, Renren::Rails::Routing::MapperExtensions
