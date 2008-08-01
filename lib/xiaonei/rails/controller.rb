require 'xiaonei'
module Xiaonei
  module Rails
    module Controller
      def self.included(controller)
        controller.extend(ClassMethods) 
      end
      
      attr_reader :xiaonei_session 
      
      def set_xiaonei_session
        if @xiaonei_session.nil?
          @xiaonei_session = Session.new(params)
          if @xiaonei_session.in_iframe
            session[:xiaonei_session] = @xiaonei_session
          end
          if @xiaonei_session.session_key.nil?
            @xiaonei_session = session[:xiaonei_session]
          end
        end
        @xiaonei_session
      end
      
      module ClassMethods
        def acts_as_xiaonei_controller
          before_filter :set_xiaonei_session
        end
      end
    end
  end
end
