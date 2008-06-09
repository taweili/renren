= xiaonei

http://xiaonei.rubyforge.org/

== DESCRIPTION:

This is the client library for xiaonei.com API. Xiaonei is the leading
social network in China.

== FEATURES/PROBLEMS:

* Making writing Xiaonei application as easy as writting web app

== SYNOPSIS:

class HomeController < ApplicationController
  acts_as_xiaonei_controller
  
  def index
    @user = xiaonei_session.invoke_method("xiaonei.users.getInfo", :uids => "229615263", :fields => Xiaonei::User.attr_names.join(","))
    @user = @user.first
    @friends = xiaonei_session.invoke_method("xiaonei.friends.getFriends")
  end
end


== REQUIREMENTS:

* No dependency outside of standard Rails and Ruby distribution

== INSTALL:

# rails my_xiaonei_app
# cd my_xiaonei_app/vendor/plugins
# git clone git://rubyforge.org/xiaonei.git

== LICENSE:

		   GNU LESSER GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>
 Everyone is permitted to copy and distribute verbatim copies
 of this license document, but changing it is not allowed.
