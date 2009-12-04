# -*- coding: utf-8 -*-
require File.dirname(__FILE__) + '/../spec_helper.rb'
require "xiaonei/session"

ENV['XIAONEI_API_KEY'] = 'ec9e57913c5b42b282ab7b743559e1b0'
ENV['XIAONEI_SECRET_KEY'] = '7fbf9791036749cb82e74efd62e9eb38'

describe Xiaonei::Session do

  describe "compute the signature" do
    before(:each) do
      @xn_params = {
        'v' => '1.0',
        'api_key' => 'ec9e57913c5b42b282ab7b743559e1b0',
        'method' => 'xiaonei.users.getLoggedInUser',
        'call_id' => '1232095295656',
        'session_key' => 'L6Xe8dXVGISZ17LJy7GzZaeYGpeGfeNdqEPLNUtCJfxPCxCRLWT83x+s/Ur94PqP-700001044'
      }
      @xn_sig = '66f332c08191b8a5dd3477d36f3af49f'
      @xn_secret = '7fbf9791036749cb82e74efd62e9eb38'
    end

    it "generates correct signature" do
      session = Xiaonei::Session.new @xn_params
      sig = session.compute_sig @xn_params
      sig.should eql(@xn_sig)
    end
  end

end

