require "xiaonei/service"
require "xiaonei/session"

class HomeController < ApplicationController
  def index
    session = Xiaonei::Session.new()
    session.session_key = params[:xn_sig_session_key]
    @res = session.invoke_method("xiaonei.users.getInfo", :uids => "223065501", :fields => [:name, :sex, :hometown_location].join(","))
    logger.debug("#{@res.inspect} - #{@res.body}")
    @res = session.invoke_method("xiaonei.friends.getFriends")
    logger.debug("#{@res.inspect} - #{@res.body}")
  end
end
