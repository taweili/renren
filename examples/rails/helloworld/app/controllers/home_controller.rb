class HomeController < ApplicationController
  acts_as_xiaonei_controller
  
  def index
    @is_app_user = xiaonei_session.invoke_method("xiaonei.users.isAppAdded")
    logger.debug("#{@is_app_user.inspect}")
    
    @logged_in_user = xiaonei_session.invoke_method("xiaonei.users.getLoggedInUser")
    logger.debug("#{@logged_in_user.inspect}")

    @set_xnml = xiaonei_session.invoke_method("xiaonei.profile.setXNML", :profile => "Hello World")
    logger.debug("#{@set_xnml.inspect}")
    
    @user = xiaonei_session.invoke_method("xiaonei.users.getInfo", :uids => "229615263", :fields => Xiaonei::User.attr_names.join(","))
    @user = @user.first
    logger.debug("#{@user.inspect}")
    
    @friends = xiaonei_session.invoke_method("xiaonei.friends.getFriends")
    logger.debug("#{@friends.inspect}")
    
    @are_friends = xiaonei_session.invoke_method("xiaonei.friends.areFriends", :uid1 => "243357028", :uid2 => "223351886")
    logger.debug("#{@are_friends.inspect}")
    
    @app_friends = xiaonei_session.invoke_method("xiaonei.friends.getAppUsers")
    logger.debug("#{@app_friends.inspect}")

  end
end
