require 'renren'
module Renren
  module Rails
    module Controller
      def self.included(controller)
        controller.extend(ClassMethods) 
      end
      
      attr_reader :renren_session 
      
      def set_renren_session
        if @renren_session.nil?
          @renren_session = Session.new(params)
          if @renren_session.in_iframe
            session[:renren_session] = @renren_session
          end
          if @renren_session.session_key.nil?
            @renren_session = session[:renren_session]
          end
        end
        @renren_session
      end
      
      module ClassMethods
        def acts_as_renren_controller
          before_filter :set_renren_session
        end
      end
    end
  end
end
