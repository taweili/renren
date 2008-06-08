# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper.rb'
require "xiaonei/parse"

require 'pp'

describe Xiaonei::Parse do
  describe "Handle error_response" do
    it "should return an Error on error_response" do
      result = Xiaonei::Parse.new.process(error_response_xml)
      result.class.name.should == "Xiaonei::Error"
      result.code.should == "5"
      result.msg.should == "(ip: 20.1.2.3)"
    end
  end
  
  describe "Handle users_getInfo_response" do
    it "should return an array of User" do
      result = Xiaonei::Parse.new.process(users_get_info_response_xml)
      result.class.name.should == "Array"
      result.size.should == 1
    end
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
