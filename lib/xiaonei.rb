$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'xiaonei/model'
require 'xiaonei/models/error'
require 'xiaonei/models/user'
require 'xiaonei/models/work_info'
require 'xiaonei/models/hometown_location'
require 'xiaonei/models/university_info'
require 'xiaonei/models/hs_info'
require 'xiaonei/models/contact_info'
require 'xiaonei/models/friend'
require 'xiaonei/models/album'
module Xiaonei
end
