# renren

This is the client library for renren.com API. Renren is the leading social network in China.

## Generators

<code>script/generate renren</code> will generate renren.yml under config/ directory.
<code>script/generate xd_receiver</code> will generate xd_receiver.html under public/ directory.

## Usage

1. generate renren.yml and xd_receiver.html, complete the configuration in renren.yml

2. add renren login button on view file, like this:

<pre><code><%= xn_login_button "window.location.reload();", :autologoutlink => 'true' %></code></pre>

3. include renren javscript before body end element, not before body start element ( for some bugs in renren javascript )

<pre><code>
<%= xn_connect_javascript_tag %>
<%= init_xn_connect %>
</code></pre>


## LICENSE:

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
