require File.dirname(__FILE__) + '/../spec_helper.rb'
require "xiaonei/parse"

describe Xiaonei::Parse do
  describe "Handle error_response" do
    it "should return an Error on correct document" do
      Xiaonei::Parse.new.process(error_response_xml)
    end
    
    def error_response_xml
      xml = "<error_response>" +
        "<error_code>5</error_code>" + 
        "<error_msg>(ip: 20.1.2.3)</error_msg>" + 
        "</error_response>"
    end
  end
end
