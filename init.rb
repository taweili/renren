xiaonei_config = "#{RAILS_ROOT}/config/xiaonei.yml"

if File.exist?(xiaonei_config)
  XIAONEI = YAML.load_file(xiaonei_config)[RAILS_ENV] 
  ENV['XIAONEI_API_KEY'] = XIAONEI['api_key']
  ENV['XIAONEI_SECRET_KEY'] = XIAONEI['secret_key']
  ENV['XIAONEI_RELATIVE_URL_ROOT'] = XIAONEI['canvas_page_name']
  ActionController::Base.asset_host = XIAONEI['callback_url']
end
