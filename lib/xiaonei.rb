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
require 'xiaonei/models/messages'
require 'xiaonei/models/blogs'
require 'xiaonei/models/blog'
require 'xiaonei/models/photo'
require 'xiaonei/models/guest_requests'
require 'xiaonei/models/guest'
require 'xiaonei/models/poke'
require 'xiaonei/models/wall_posts'
require 'xiaonei/models/wall_post'
require 'xiaonei/models/comment'
require 'xiaonei/models/key'

module Xiaonei

  class << self 
    def canvas_path
      ENV['XIAONEI_RELATIVE_URL_ROOT'] 
    end
    
    def canvas_server_base
      "apps.xiaonei.com"
    end
    
    def xiaonei_path_prefix
      "/" + canvas_path
    end
    
    def path_prefix
      @path_prefix
    end
    
    def request_for_canvas(is_canvas_request)
      original_path_prefix = @path_prefix 
      begin
        @path_prefix = xiaonei_path_prefix if is_canvas_request
        yield
      ensure
        @path_prefix = original_path_prefix
      end
    end
    
  end
  
end
