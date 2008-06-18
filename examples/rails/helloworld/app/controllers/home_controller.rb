class HomeController < ApplicationController
  acts_as_xiaonei_controller
  
  def index
    @is_app_user = xiaonei_session.invoke_method("xiaonei.users.isAppAdded")
    logger.debug("------xiaonei.users.isAppAdded --- #{@is_app_user.inspect}")
    
    @logged_in_user = xiaonei_session.invoke_method("xiaonei.users.getLoggedInUser")
    logger.debug("------xiaonei.users.getLoggedInUser --- #{@logged_in_user.inspect}")

    @set_xnml = xiaonei_session.invoke_method("xiaonei.profile.setXNML", :profile => "Hello World")
    logger.debug("------xiaonei.profile.setXNML --- #{@set_xnml.inspect}")
    
    @user = xiaonei_session.invoke_method("xiaonei.users.getInfo", :uids => "229615263", :fields => Xiaonei::User.attr_names.join(","))
    @user = @user.first
    logger.debug("------xiaonei.users.getInfo --- #{@user.inspect}")
    
    @friends = xiaonei_session.invoke_method("xiaonei.friends.getFriends")
    logger.debug("------xiaonei.friends.getFriends --- #{@friends.inspect}")
    
    @are_friends = xiaonei_session.invoke_method("xiaonei.friends.areFriends", :uid1 => "243357028", :uid2 => "223351886")
    logger.debug("------xiaonei.friends.areFriends --- #{@are_friends.inspect}")
    
    @app_friends = xiaonei_session.invoke_method("xiaonei.friends.getAppUsers")
    logger.debug("------xiaonei.friends.getAppUsers --- #{@app_friends.inspect}")
    
    test_method("xiaonei.profile.getXNML", :uid => xiaonei_session.user)
    
    test_method("xiaonei.feed.publishActionOfUser", :title => "hello world", :body => "hello")
    
    test_method("xiaonei.feed.publishActionToUser", :title => "hello world", :body => "hello")
    
    test_method("xiaonei.blog.gets", :uid => xiaonei_session.user)
    
    test_method("xiaonei.blog.addBlog", :title => "Hello from API", :content => "Post blog from API")
    
    test_method("xiaonei.photos.getAlbums", :uid => xiaonei_session.user)
    
    test_method("xiaonei.photos.getAlbums", :uid => xiaonei_session.user, :alubmIds => "242570156")
    
    test_method("xiaonei.photos.get", :uid => xiaonei_session.user, :aid => "242570156")
    
    test_method("xiaonei.message.gets")
    
    test_method("xiaonei.message.gets", :isInbox => true)
    
    test_method("xiaonei.xnml.refreshRefUrl", :url => url_for(:action => 'home', :only_path => false))

    test_method("xiaonei.wall.getPosts", :uid => xiaonei_session.user)
    
    test_method("xiaonei.wall.addPost", :uid => xiaonei_session.user, :content => "David post from API #{Time.now}")

  end
  
  def test
    # test_method("xiaonei.requests.poke", :uid => "246353875")
    test_method("xiaonei.blog.gets", :uid => xiaonei_session.user)
  end
  
  protected
  
  def test_method(method, params = { })
    ret = xiaonei_session.invoke_method(method, params)
    logger.debug("------#{method} --- #{ret.inspect}")
  end
end
