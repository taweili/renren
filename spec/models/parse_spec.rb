# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper.rb'
require "xiaonei/parse"

require 'pp'

describe Xiaonei::Parse do

  describe "handle return from users_getLoggedInUser_response" do
    it "should return the user id" do
      result = Xiaonei::Parse.new.process(users_get_logged_in_user_response_xml)
      result.should eql("66271")
    end
  end
  
  describe "handle return from profile_getXNML_response" do
    it "should return an array with a string" do
      pending "Until Xiaonei fixs their XML"
      result = Xiaonei::Parse.new.process(profile_get_xnml_response_xml)
      pp result.inspect
    end
  end

  describe "handle return from profile_setXNML_response" do
    it "should return a string" do
      result = Xiaonei::Parse.new.process(profile_set_xnml_response_xml)
      result.should eql("1")
    end
  end
  
  describe "handle return from profile_setXNML_response" do
    it "should return nil" do
      result = Xiaonei::Parse.new.process(empty_profile_set_xnml_response_xml)
      result.should eql([])
    end
  end


  describe "Handle error_response" do
    it "should return an Error on error_response" do
      result = Xiaonei::Parse.new.process(error_response_xml)
      result.class.name.should == "Xiaonei::Error"
      result.code.should == "5"
      result.msg.should == "(ip: 20.1.2.3)"
    end
  end
  
  describe "Handle users_getInfo_response with new empty attr" do
    it "should return an array of User" do
      result = Xiaonei::Parse.new.process(users_get_info_response_with_new_empty_attr_xml)
      result.should be_a_kind_of(Array)
      result.size.should == 1
      result.first.should be_a_kind_of(Xiaonei::User)
      result.first.uid.should eql("8055")
    end
  end

  
  describe "Handle users_getInfo_response with new attr" do
    it "should return an array of User" do
      result = Xiaonei::Parse.new.process(users_get_info_response_with_new_attr_xml)
      result.should be_a_kind_of(Array)
      result.size.should == 1
      result.first.should be_a_kind_of(Xiaonei::User)
      result.first.uid.should eql("8055")
    end
  end

  
  describe "Handle users_getInfo_response with work history" do
    it "should return an array of User" do
      result = Xiaonei::Parse.new.process(users_get_info_response_work_history_xml)
      result.should be_a_kind_of(Array)
      result.size.should == 1
    end
  end
  
  describe "Handle users_getInfo_response" do
    it "should return an array of User" do
      result = Xiaonei::Parse.new.process(users_get_info_response_xml)
      result.should be_a_kind_of(Array)
      result.size.should == 1
    end
  end
  
  describe "Handle friends_getFriends_response" do
    it "should return an array of User" do
      result = Xiaonei::Parse.new.process(friends_get_friends_response_xml)
      result.should be_a_kind_of(Array)
      result.size.should eql(20)
      result.total.should eql("87") 
    end
  end
  
  describe "photos_getAlbums_response" do
    it "should return an array of Album" do
      result = Xiaonei::Parse.new.process(friends_get_friends_response_xml)
      result.should be_a_kind_of(Array)
      result.size.should eql(20)
      result.total.should eql("87") 
    end
  end
  
  describe "blog_gets_response" do
    it "should return an array of blogs" do
      result = Xiaonei::Parse.new.process(blog_gets_response_xml)
      result.should be_a_kind_of(Array)
      result.size.should eql(2)
    end
  end
  
  describe "requests_get_guest_requests_response" do
    it "should return an array of guests" do
      result = Xiaonei::Parse.new.process(requests_get_guest_requests_response_xml)
      result.should be_a_kind_of(Array)
      result.size.should eql(1)
    end
  end
  
  describe "requests_get_pokes_response" do
    it "should return an array of pokes" do
      result = Xiaonei::Parse.new.process(requests_get_pokes_response_xml)
      result.should be_a_kind_of(Array)
      result.size.should eql(1)
    end
    
    it "should return an array of pokes" do
      result = Xiaonei::Parse.new.process(requests_get_pokes_response_cdata_xml)
      result.should be_a_kind_of(Array)
      result.size.should eql(1)
      result[0].name.should eql("李大维")
    end

  end
  
  describe "wall_get_posts_response" do
    it "should return an array of comments" do
      result = Xiaonei::Parse.new.process(wall_get_posts_response_xml)
      result.total.should eql("73")
    end
  end
  
  describe "wall_add_post_response" do
    it "should return an WallPost with id" do
      result = Xiaonei::Parse.new.process(wall_add_post_response_xml)
      result.id.should eql("2471453823")
    end
  end

  describe "friends_getAppUsers_response" do
    it "should return an array of User" do
      result = Xiaonei::Parse.new.process(friends_get_app_users_response_xml)
      result.size.should eql(2)
      result[0].should eql("222332")
      result[1].should eql("222333")
    end

    it "should return an empty array" do
      result = Xiaonei::Parse.new.process(empty_friends_get_app_users_response_xml)
      result.size.should eql(0)
    end
    
  end
  
  describe "requests_sendRequest_response" do
    it "should return an array of User" do
      result = Xiaonei::Parse.new.process(requests_send_request_response_xml)
      result.size.should eql(2)
      result[0].should eql("123")
      result[1].should eql("223")
    end
  end
  
  describe "auth_getSession_response" do
    it "should return a session_key" do 
      result = Xiaonei::Parse.new.process(auth_get_session_response_xml)
    end
  end

  def auth_get_session_response_xml
    <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
      <auth_getSession_response 
         xmlns="http://api.xiaonei.com/1.0/" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
         xsi:SchemaLocation="http://api.xiaonei.com/1.0/xiaonei.xsd">
        <session_key>ttl1vNZ+v4DDbw4WP3fS+iopMhY0UvpXlmKQVBC4v9rEkpoTavJGb0E/gVYBjosV-230034168</session_key>
        <uid>230034168</uid>
      </auth_getSession_response>	
    XML
  end
  def requests_send_request_response_xml
    <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
      <requests_sendRequest_response xmlns="http://api.xiaonei.com/1.0/"
	                             xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
	                             xsi:schemaLocation="http://api.xiaonei.com/1.0/ http://api.xiaonei.com/1.0/xiaonei.xsd">
	<uid>123</uid>
	<uid>223</uid>
      </requests_sendRequest_response>
    XML
  end


  def empty_friends_get_app_users_response_xml
    <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
      <friends_getAppUsers_response 
         xmlns="http://api.xiaonei.com/1.0/" 
         xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" 
         xsi:schemaLocation="http://api.xiaonei.com/1.0/ http://api.xiaonei.com/1.0/xiaonei.xsd">
      </friends_getAppUsers_response>
    XML
  end
  
  def friends_get_app_users_response_xml
    <<-XML
      <friends_getAppUsers_response list="true">
        <uid>222332</uid>
        <uid>222333</uid> 
      </friends_getAppUsers_response>
    XML
  end
  
  def wall_add_post_response_xml
    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<wall_addPost_response>
  <id>2471453823</id>
</wall_addPost_response>"
XML
  end
  def wall_get_posts_response_xml
    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<wall_getPosts_response>
  <uid>243357028</uid>
  <name>李大维</name>
  <total>73</total>
  <comments list="true">
    <comment>
      <id>2466480665</id>
      <uid>200234934</uid>
      <name>王兴宗</name>
      <time>2008-06-12 03:15:00</time>
      <tinyurl>http://head.xiaonei.com/photos/20070616/13/37/tiny36939.jpg</tinyurl>
      <text>回复李大维：thanks!\r\nlearning ruby 这本书我看过了。最后用那个实例addressbook还没有调试成功，在生成脚手架的时候书上的代码是这样的：XXXXXXenreate scaffold address address\r\n\r\n我输入的时候却返回参数错误&amp;lt;2 for 1&amp;gt;.\r\n我只用一个参数address的时候却能成功生成。\r\n但是在浏览器打开localhost：3000/address 的时候却返回找不到表addresses。数据库里确实有这个表。。。。。。\r\nwhy？？\r\n和平台有关系吗？\r\n我用的是windows xp\r\ninstall rails 2.0.2</text>
    </comment>
    <comment>
      <id>2466142031</id>
      <uid>238943997</uid>
      <name>sophia</name>
      <time>2008-06-12 02:11:50</time>
      <tinyurl>http://hd27.xiaonei.com/photos/hd27/20080611/16/33/tiny_3207h169.jpg</tinyurl>
      <text>回复李大维：晓得鸟~ 福松同学也不在线，这些交互接口，估计还得再等待一阵，才能实现：）</text>
    </comment>
    <comment>
      <id>2466074386</id>
      <uid>238943997</uid>
      <name>sophia</name>
      <time>2008-06-12 01:59:00</time>
      <tinyurl>http://hd27.xiaonei.com/photos/hd27/20080611/16/33/tiny_3207h169.jpg</tinyurl>
      <text>回复李大维：技术 看完了，说这些通知好友呀，短信呀的接口都没有开放呢，不能使用呀：（</text>
    </comment>
    <comment>
      <id>2465538345</id>
      <uid>238943997</uid>
      <name>sophia</name>
      <time>2008-06-12 12:33:43</time>
      <tinyurl>http://hd27.xiaonei.com/photos/hd27/20080611/16/33/tiny_3207h169.jpg</tinyurl>
      <text>回复李大维：谢鸟~</text>
    </comment>
    <comment>
      <id>2465077760</id>
      <uid>243357028</uid>
      <name>李大维</name>
      <time>2008-06-12 11:15:35</time>
      <tinyurl>http://hd51.xiaonei.com/photos/hd51/20080504/00/09/tiny_10137n107.jpg</tinyurl>
      <text>回复sophia：\n\nhttp://group.xiaonei.com/GetThread.do?id=326001767&amp;amp;curpage=0&amp;amp;parentpage=0&amp;amp;tribeId=237768885</text>
    </comment>
    <comment>
      <id>2465025685</id>
      <uid>238943997</uid>
      <name>sophia</name>
      <time>2008-06-12 11:05:33</time>
      <tinyurl>http://hd27.xiaonei.com/photos/hd27/20080611/16/33/tiny_3207h169.jpg</tinyurl>
      <text>回复李大维：丁懿 问你的这个问题，我也想问下，但不知道在论坛的什么位置可以看到你的回复？ THX</text>
    </comment>
    <comment>
      <id>2464577601</id>
      <uid>243357028</uid>
      <name>李大维</name>
      <time>2008-06-12 09:34:01</time>
      <tinyurl>http://hd51.xiaonei.com/photos/hd51/20080504/00/09/tiny_10137n107.jpg</tinyurl>
      <text>回复丁懿：在论坛上回复了。;&amp;#41;</text>
    </comment>
    <comment>
      <id>2464564237</id>
      <uid>234960294</uid>
      <name>丁懿</name>
      <time>2008-06-12 09:30:26</time>
      <tinyurl>http://hd51.xiaonei.com/photos/hd51/20080609/15/47/tiny_4301p169.jpg</tinyurl>
      <text>你好，请教一个问题\r\n怎么在校内api应用中实现向好友发送提示信息，比如做了一个东西，怎么提示好友发生了这么一件事</text>
    </comment>
    <comment>
      <id>2464038097</id>
      <uid>243357028</uid>
      <name>李大维</name>
      <time>2008-06-12 12:48:59</time>
      <tinyurl>http://hd51.xiaonei.com/photos/hd51/20080504/00/09/tiny_10137n107.jpg</tinyurl>
      <text>回复陆俊江：大家一起讨论。;&amp;#41;</text>
    </comment>
    <comment>
      <id>2463972037</id>
      <uid>224140423</uid>
      <name>陆俊江</name>
      <time>2008-06-12 12:31:56</time>
      <tinyurl>http://hd15.xiaonei.com/photos/hd15/20080603/23/19/tiny_6320f107.jpg</tinyurl>
      <text>牛哥，我要向你学习啊</text>
    </comment>
  </comments>
</wall_getPosts_response>
XML
  end
  
  def requests_get_pokes_response_xml
    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<requests_getPokes_response list="true">
  <total>1</total>
  <poke>
    <uid>246353875</uid>
    <name>李大维</name>
    <time>2008-06-13 08:02:33</time>
    <id>632699651</id>
  </poke>
</requests_getPokes_response>
XML
  end
  
  def requests_get_pokes_response_cdata_xml
    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<requests_getPokes_response list="true">
  <total>1</total>
  <poke>
    <uid>246353875</uid>
    <name><![CDATA[李大维]]></name>
    <time>2008-06-13 08:02:33</time>
    <id>632699651</id>
  </poke>
</requests_getPokes_response>
XML
  end


  def requests_get_guest_requests_response_xml
  <<-XML
  <?xml version="1.0" encoding="UTF-8"?>
<requests_getGuestRequests_response list="true">
  <total>1</total>
  <guest>
    <headurl>http://head.xiaonei.com/photos/0/0/head.jpg</headurl>
    <uid>246353875</uid>
    <name>李大维</name>
    <network>上海市</network>
  </guest>
</requests_getGuestRequests_response>
XML
  end
  
  def blog_gets_response_xml
    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<blog_gets_response list="true">
  <uid>243357028</uid>
  <name>李大维</name>
  <total>2</total>
  <blog>
    <id>301567087</id>
    <title>为什么校内的XML资料结构那么奇怪呢？</title>
    <time>2008-06-13 07:25:14</time>
    <view_count>1</view_count>
    <comment_count>0</comment_count>
  </blog>
  <blog>
    <id>301566923</id>
    <title>反向工程校内API</title>
    <time>2008-06-13 07:19:35</time>
    <view_count>1</view_count>
    <comment_count>0</comment_count>
  </blog>
</blog_gets_response>
XML
  end
  def photos_get_albums_response_xml
    <<-XML
    <photos_getAlbums_response list="true">
  <total>1</total>
  <album>
    <aid>242570156</aid>
    <uid>243357028</uid>
    <url>http://fm481.img.xiaonei.com/pic001/20080509/21/58/main_5827e70.jpg</url>
    <name>人像</name>
    <size>2</size>
    <create_time>2008-05-09 10:00:59</create_time>
    <update_time>2008-05-09 10:02:04</update_time>
  </album>
</photos_getAlbums_response>
XML
  end

  def users_get_logged_in_user_response_xml
    <<-XML
      <?xml version="1.0" encoding="UTF-8"?>
<users_getLoggedInUser_response list="true" >66271</users_getLoggedInUser_response>
XML
  end
  
  def error_response_xml
    <<-XML 
<?xml version="1.0" encoding="UTF-8"?>
<error_response>
  <error_code>5</error_code>
  <error_msg>(ip: 20.1.2.3)</error_msg>
</error_response>
XML
  end

  def users_get_info_response_with_new_empty_attr_xml
    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<users_getInfo_response list="true">
  <user>
    <uid>8055</uid>
  </user>
</users_getInfo_response>
XML
  end

  def users_get_info_response_with_new_attr_xml
    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<users_getInfo_response list="true">
  <user>
    <uid>8055</uid>
  </user>
</users_getInfo_response>
XML
  end
  
  def profile_get_xnml_response_xml
    <<-XML
  <?xml version="1.0" encoding="UTF-8"?>
<profile_getXNML list="true">
   Hello <xn:name uid="00000" linked="true" shownetwork="true" />
</ profile_getXNML >
XML
  end

  def profile_set_xnml_response_xml
    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<profile_setXNML_response list="true">1</profile_setXNML_response>
XML
  end
  
  def empty_profile_set_xnml_response_xml
    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<profile_setXNML_response></profile_setXNML_response>
XML
  end

  
  def users_get_info_response_work_history_xml
    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<users_getInfo_response list="true">
  <user>
    <uid>8055</uid>
    <work_history list="true">
      <work_info>
        <company_name>千橡互联</company_name>
        <description>一家互联网公司</description>
        <start_date>2006-01</start_date>
        <end_date/>
      </work_info>
    </work_history>
  </user>
</users_getInfo_response>
XML
  end

  def users_get_info_response_xml
      <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<users_getInfo_response list="true">
  <user>
    <uid>8055</uid>
    <name>刘德华</name>
    <sex>1</sex>
    <birthday>1961-09-27</birthday>
    <tinyurl>http://head.xiaonei.com/photos/tiny_10942g177.jpg</tinyurl>
    <headurl>http://head.xiaonei.com/photos/tiny_10942g177.jpg</headurl>
    <mainurl>http://head.xiaonei.com/photos/tiny_10942g177.jpg</mainurl>
    <hometown_location>
      <country>中国</country>
      <province>黑龙江</province>
      <city>哈尔滨</city>
    </hometown_location>
    <work_history list="true">
      <work_info>
        <company_name>千橡互联</company_name>
        <description>一家互联网公司</description>
        <start_date>2006-01</start_date>
        <end_date/>
      </work_info>
    </work_history>	
    <university_history list="true">
      <university_info>
        <name>北京第二外国语学院</name>
        <year>2003</year>
        <department>人文学院</department>
      </university_info>
    </university_history>
    <hs_history list="true">
      <hs_info>
        <name>黑龙江省实验中学</name>
        <grad_year>1999</grad_year>
      </hs_info>
    </hs_history>
    <contact_info>
      <msn>fulong@hotmail.com</msn>
      <mobile_tel>13366256895</mobile_tel>
      <telephone>85252558-1022</telephone>
      <web_site>http://www.xiaonei.com/getuser.do?id=123</web_site>
    </contact_info>
    <books>红楼梦,狼图腾,福尔摩斯探案精选</books>
    <movies>色戒（梁朝伟 汤唯）,蓝莓之夜（简装DVD）</movies>
    <music>忘情水,义勇军进行曲</music>	
  </user>
</users_getInfo_response>
XML
  end
  
  def friends_get_friends_response_xml
    <<-XML
<?xml version="1.0" encoding="UTF-8"?>
<friends_getFriends_response list="true">
  <total>87</total>
  <friend>
    <id>10131</id>
    <name>梁栋</name>
    <headurl>http://hd22.xiaonei.com/photos/hd22/20071123/23/30/head_7076k107.jpg</headurl>
    <network_id>1004</network_id>
    <network_name>北京航空航天大学</network_name>
  </friend>
  <friend>
    <id>68126</id>
    <name>赵宁</name>
    <headurl>http://head.xiaonei.com/photos/68/126/head40358.jpg</headurl>
    <network_id>5002</network_id>
    <network_name>东北大学</network_name>
  </friend>
  <friend>
    <id>28094875</id>
    <name>王渊命</name>
    <headurl>http://head.xiaonei.com/photos/20070624/22/07/head_3612f56.jpg</headurl>
    <network_id>60001001</network_id>
    <network_name>北京市</network_name>
  </friend>
  <friend>
    <id>28650033</id>
    <name>杜子兮</name>
    <headurl>http://hd52.xiaonei.com/photos/hd52/20080606/02/06/head_7583c107.jpg</headurl>
    <network_id>5001</network_id>
    <network_name>大连理工</network_name>
  </friend>
  <friend>
    <id>39588524</id>
    <name>梁公军</name>
    <headurl>http://hd14.xiaonei.com/photos/hd14/20080425/00/16/head_5179l150.jpg</headurl>
    <network_id>60001001</network_id>
    <network_name>北京市</network_name>
  </friend>
  <friend>
    <id>48792716</id>
    <name>冯浩♥China</name>
    <headurl>http://hd27.xiaonei.com/photos/hd27/20080523/17/00/head_6159k150.jpg</headurl>
    <network_id>16054</network_id>
    <network_name>烟台南山学院</network_name>
  </friend>
  <friend>
    <id>50030891</id>
    <name>焦跃</name>
    <headurl>http://hd20.xiaonei.com/photos/hd20/20070722/00/14/head_10591a72.jpg</headurl>
    <network_id>2002</network_id>
    <network_name>上海交通大学</network_name>
  </friend>
  <friend>
    <id>52277711</id>
    <name>张志强</name>
    <headurl>http://hd34.xiaonei.com/photos/hd34/20080423/21/43/head_5947l107.jpg</headurl>
    <network_id>16051</network_id>
    <network_name>烟台大学</network_name>
  </friend>
  <friend>
    <id>53480507</id>
    <name>高山</name>
    <headurl>http://hd25.xiaonei.com/photos/hd25/20080310/22/47/head_9045m169.jpg</headurl>
    <network_id>300001</network_id>
    <network_name>National University of Singapore</network_name>
  </friend>
  <friend>
    <id>63437474</id>
    <name>王琦bakin</name>
    <headurl>http://hd22.xiaonei.com/photos/hd22/20071129/16/01/head_4493o107.jpg</headurl>
    <network_id>4016</network_id>
    <network_name>长春工业大学</network_name>
  </friend>
  <friend>
    <id>78953558</id>
    <name>小怒</name>
    <headurl>http://hd51.xiaonei.com/photos/hd51/20080520/14/49/head_2999m150.jpg</headurl>
    <network_id>1029</network_id>
    <network_name>首都师范大学</network_name>
  </friend>
  <friend>
    <id>80288196</id>
    <name>江云帆</name>
    <headurl>http://hd33.xiaonei.com/photos/hd33/20080205/12/55/head_1436h169.jpg</headurl>
    <network_id>60009001</network_id>
    <network_name>杭州市</network_name>
  </friend>
  <friend>
    <id>85432256</id>
    <name>黄晶</name>
    <headurl>http://hd34.xiaonei.com/photos/hd34/20080522/10/06/head_587n150.jpg</headurl>
    <network_id>1001</network_id>
    <network_name>清华大学</network_name>
  </friend>
  <friend>
    <id>143430531</id>
    <name>孙雪峰</name>
    <headurl>http://hd14.xiaonei.com/photos/hd14/20080505/09/30/head_489k107.jpg</headurl>
    <network_id>20001001</network_id>
    <network_name>千橡互动</network_name>
  </friend>
  <friend>
    <id>148834358</id>
    <name>杨智强Andy</name>
    <headurl>http://hd15.xiaonei.com/photos/hd15/20080526/13/16/head_1866i169.jpg</headurl>
    <network_id>26001</network_id>
    <network_name>内蒙古大学</network_name>
  </friend>
  <friend>
    <id>164613341</id>
    <name>蒋洁</name>
    <headurl>http://hd15.xiaonei.com/photos/hd15/20080602/19/24/head_5039c150.jpg</headurl>
    <network_id>5061</network_id>
    <network_name>沈阳航空工业学院</network_name>
  </friend>
  <friend>
    <id>192248596</id>
    <name>lzz∮┟</name>
    <headurl>http://hd52.xiaonei.com/photos/hd52/20080605/17/11/head_3574c107.jpg</headurl>
    <network_id>8012</network_id>
    <network_name>南邮</network_name>
  </friend>
  <friend>
    <id>200000108</id>
    <name>唐炜</name>
    <headurl>http://hd27.xiaonei.com/photos/hd27/20080523/13/23/head_3175n107.jpg</headurl>
    <network_id>20001001</network_id>
    <network_name>千橡互动</network_name>
  </friend>
  <friend>
    <id>200000548</id>
    <name>蒲忠杰</name>
    <headurl>http://head.xiaonei.com/photos/20070411/0950/head55914.jpg</headurl>
    <network_id>60001001</network_id>
    <network_name>北京市</network_name>
  </friend>
  <friend>
    <id>200003551</id>
    <name>张洪波</name>
    <headurl>http://hd51.xiaonei.com/photos/hd51/20080602/14/57/head_2734a150.jpg</headurl>
    <network_id>1999</network_id>
    <network_name>朝阳二外</network_name>
  </friend>
</friends_getFriends_response>
XML
  end
end
