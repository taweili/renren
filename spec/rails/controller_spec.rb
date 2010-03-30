require File.dirname(__FILE__) + '/../spec_helper.rb'
require "renren/rails/controller"

describe Renren::Rails::Controller do
  include Renren::Rails::Controller

  describe "secure with cookie" do
    
    it "should get a correct session" do
      
      Renren.renren_config['api_key'] = '2bdd0c9fdafb46fbbf7ed0a12c120cf6'
      Renren.renren_config['secret_key'] = '98ea3be8a5d944ba96e501e729ef8b91'
      
      stub!(:cookies).and_return({
        '2bdd0c9fdafb46fbbf7ed0a12c120cf6_expires' => '1269928800',
        '2bdd0c9fdafb46fbbf7ed0a12c120cf6_session_key' => '3.57591bb29491cbb7542a02613cfd8685.3600.1269928800-239839315',
        '2bdd0c9fdafb46fbbf7ed0a12c120cf6_ss' => '382d6bf798c78e759cae48a1e279dbcb',
        '2bdd0c9fdafb46fbbf7ed0a12c120cf6_user' => '239839315',
        '2bdd0c9fdafb46fbbf7ed0a12c120cf6' => '2b888197d80a2bdf1873bb2fe9a19057'
      })
      stub!(:session).and_return({})
      stub!(:params).and_return({})
      
      renren_session = set_renren_session
      renren_session.should_not be_nil
    end
    
    it "should get a nil session" do
      
      Renren.renren_config['api_key'] = '2bdd0c9fdafb46fbbf7ed0a12c120cf6'
      Renren.renren_config['secret_key'] = '98ea3be8a5d944ba96e501e729ef8b91'
      
      stub!(:cookies).and_return({
        '2bdd0c9fdafb46fbbf7ed0a12c120cf6_expires' => '1269928800',
        '2bdd0c9fdafb46fbbf7ed0a12c120cf6_session_key' => '3.57591bb29491cbb7542a02613cfd8685.3600.1269928800-239839315',
        '2bdd0c9fdafb46fbbf7ed0a12c120cf6_ss' => '382d6bf798c78e759cae48a1e279dbcb',
        '2bdd0c9fdafb46fbbf7ed0a12c120cf6_user' => '239839315',
        '2bdd0c9fdafb46fbbf7ed0a12c120cf6' => ''
      })
      stub!(:session).and_return({})
      stub!(:params).and_return({})
      
      lambda { set_renren_session }.should raise_error(Renren::Session::IncorrectSignature)
    end
  end
end

