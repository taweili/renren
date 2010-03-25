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

(The MIT License)

Copyright (c) 2008 David Li

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
