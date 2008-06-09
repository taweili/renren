require "xiaonei/service"
require "xiaonei/session"

class HomeController < ApplicationController
  acts_as_xiaonei_controller
  
  def index
    @user = xiaonei_session.invoke_method("xiaonei.users.getInfo", :uids => "229615263", :fields => Xiaonei::User.attr_names.join(","))
    @user = @user.first
    logger.debug("#{@user.inspect}")
    @friends = xiaonei_session.invoke_method("xiaonei.friends.getFriends")
    logger.debug("#{@friends.inspect}")
  end
end
