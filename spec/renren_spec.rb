require File.dirname(__FILE__) + '/spec_helper.rb'

describe "Renren" do
  
  it "load_configuration" do
    RAILS_ENV = 'test'
    Renren.load_configuration(File.dirname(__FILE__) + "/config/renren.yml")
    Renren.api_key.should == "296e8e42ff854545a1ac6fc1002666bf"
    Renren.secret_key.should == "4c82528bffea402ba4750c2c35b1c083"
  end
end
