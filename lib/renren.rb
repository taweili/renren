$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'renren/model'
require 'renren/models/error'
require 'renren/models/user'
require 'renren/models/work_info'
require 'renren/models/hometown_location'
require 'renren/models/university_info'
require 'renren/models/hs_info'
require 'renren/models/contact_info'
require 'renren/models/friend'
require 'renren/models/album'
require 'renren/models/messages'
require 'renren/models/blogs'
require 'renren/models/blog'
require 'renren/models/photo'
require 'renren/models/guest_requests'
require 'renren/models/guest'
require 'renren/models/poke'
require 'renren/models/wall_posts'
require 'renren/models/wall_post'
require 'renren/models/comment'
require 'renren/models/key'

module Renren

  class << self 
    def canvas_path
      ENV['RENREN_RELATIVE_URL_ROOT'] 
    end
    
    def canvas_server_base
      "apps.renren.com"
    end
    
    def renren_path_prefix
      "/" + canvas_path
    end
    
    def path_prefix
      @path_prefix
    end
    
    def request_for_canvas(is_canvas_request)
      original_path_prefix = @path_prefix 
      begin
        @path_prefix = renren_path_prefix if is_canvas_request
        yield
      ensure
        @path_prefix = original_path_prefix
      end
    end
    
  end
  
end
