require "xiaonei/service"

class HomeController < ApplicationController
  def index
    service = Xiaonei::Service.new(ENV['XIAONEI_API_KEY'])
    @res = service.post(:method => "xiaonei.users.getInfo", :api_key => ENV['XIAONEI_API_KEY'], :session_key => params[:xn_sig_session_key], :v => "1.0", :uids => params[:xn_sig_user])
    logger.debug("#{@res.inspect} - #{@res.body}")
  end
end
