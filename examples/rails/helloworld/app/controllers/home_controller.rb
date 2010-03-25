class HomeController < ApplicationController
  acts_as_renren_controller
  # before_filter :print_renren_session
  
  def print_renren_session
    logger.debug("### renren_session = #{renren_session.inspect}")
  end
  
  def get_info
    render :action => :index
  end
  
  def index
    @friend_ids = test_method("renren.friends.get")
    @friend_ids = @friend_ids[0..23]
  end
  
  def test_all
    @is_app_user = renren_session.invoke_method("renren.users.isAppAdded")
    logger.debug("------renren.users.isAppAdded --- #{@is_app_user.inspect}")
    
    @logged_in_user = renren_session.invoke_method("renren.users.getLoggedInUser")
    logger.debug("------renren.users.getLoggedInUser --- #{@logged_in_user.inspect}")

    @set_xnml = renren_session.invoke_method("renren.profile.setXNML", :uid => renren_session.user, :profile => "Hello World", :profile_action => "http://apps.renren.com/taweili/home")
    logger.debug("------renren.profile.setXNML --- #{@set_xnml.inspect}")
    
    @user = renren_session.invoke_method("renren.users.getInfo", :uids => "229615263", :fields => Renren::User.attr_names.join(","))
    @user = @user.first
    logger.debug("------renren.users.getInfo --- #{@user.inspect}")
    
     @friends = renren_session.invoke_method("renren.friends.getFriends")
     logger.debug("------renren.friends.getFriends --- #{@friends.inspect}")
    
    @are_friends = renren_session.invoke_method("renren.friends.areFriends", :uid1 => "243357028", :uid2 => "223351886")
    logger.debug("------renren.friends.areFriends --- #{@are_friends.inspect}")
    
    @app_friends = renren_session.invoke_method("renren.friends.getAppUsers")
    logger.debug("------renren.friends.getAppUsers --- #{@app_friends.inspect}")
    
    test_method("renren.profile.getXNML", :uid => renren_session.user)
    
    test_method("renren.feed.publishActionOfUser", :title => "<xn:name uid='#{renren_session.user}'/> loves David", :body => "<xn:name uid='#{renren_session.user}'/> loves David #{Time.now}")
    
    test_method("renren.feed.publishActionToUser", :title => "hello world", :body => "hello")
    
    test_method("renren.blog.gets", :uid => renren_session.user)
    
    test_method("renren.blog.addBlog", :title => "Hello from API", :content => "Post blog from API")
    
    test_method("renren.photos.getAlbums", :uid => renren_session.user)
    
    test_method("renren.photos.getAlbums", :uid => renren_session.user, :alubmIds => "242570156")
    
    test_method("renren.photos.get", :uid => renren_session.user, :aid => "242570156")
    
    test_method("renren.message.gets")
    
    test_method("renren.message.gets", :isInbox => true)
    
    test_method("renren.xnml.refreshRefUrl", :url => url_for(:action => 'home', :only_path => false))

    test_method("renren.wall.getPosts", :uid => renren_session.user)
    
    test_method("renren.wall.addPost", :uid => renren_session.user, :content => "David post from API #{Time.now}")
    
    test_method("renren.requests.sendRequest", :uids => "246353875")
    
    test_method("renren.feed.publishTemplatizedAction", :template_id => 1, :body_data => {}.to_json, :title_data => {}.to_json)
    
    test_method("renren.notifications.send", :to_ids => "<%=renren_session.user%>", :notification => "<xn:name uid='243357028'/> is testing <a href='http://www.hainei.com'>Notification</a>")
    
    render :action => :index
  end
  
  def test
    # test_method("renren.requests.poke", :uid => "246353875")
    test_method("renren.friends.get")
    render :action => :index
  end
  
  protected
  
  def test_method(method, params = { })
    ret = renren_session.invoke_method(method, params)
    logger.debug("------#{method} --- #{ret.inspect}")
    ret
  end
end
