require "xiaonei/service"
require "xiaonei/session"

class HomeController < ApplicationController
  def index
    session = Xiaonei::Session.new()
    session.session_key = params[:xn_sig_session_key]
    
    @user = session.invoke_method("xiaonei.users.getInfo", :uids => "229615263", :fields => Xiaonei::User.attr_names.join(","))
    @user = @user.first
    logger.debug("#{@user.inspect}")
    @friends = session.invoke_method("xiaonei.friends.getFriends")
  end
end
