class HomeController < ApplicationController
  acts_as_xiaonei_controller
  
  def info
    @user = xiaonei_session.invoke_method("xiaonei.users.getInfo", :uids => "243357028", :fields => "uid,name,birthday,headurl")
    @user = @user.first
    logger.debug("------xiaonei.users.getInfo --- #{@user.inspect}")
    render :action => :index
  end
  
  def index
    @is_app_user = xiaonei_session.invoke_method("xiaonei.users.isAppAdded")
    logger.debug("------xiaonei.users.isAppAdded --- #{@is_app_user.inspect}")
    
    @logged_in_user = xiaonei_session.invoke_method("xiaonei.users.getLoggedInUser")
    logger.debug("------xiaonei.users.getLoggedInUser --- #{@logged_in_user.inspect}")

    @set_xnml = xiaonei_session.invoke_method("xiaonei.profile.setXNML", :uid => xiaonei_session.user, :profile => "Hello World", :profile_action => "http://apps.xiaonei.com/taweili/home")
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
    
    test_method("xiaonei.feed.publishActionOfUser", :title => "<xn:name uid='#{xiaonei_session.user}'/> loves David", :body => "<xn:name uid='#{xiaonei_session.user}'/> loves David #{Time.now}")
    
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
    
    test_method("xiaonei.requests.sendRequest", :uids => "246353875")
    
    test_method("xiaonei.feed.publishTemplatizedAction", :template_id => 1, :body_data => {}.to_json, :title_data => {}.to_json)
    
    test_method("xiaonei.notifications.send", :to_ids => "<%=xiaonei_session.user%>", :notification => "<xn:name uid='243357028'/> is testing <a href='http://www.hainei.com'>Notification</a>")
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
