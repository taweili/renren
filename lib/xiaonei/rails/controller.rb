require 'xiaonei'
module Xiaonei
  module Rails
    module Controller
      def self.included(controller)
        controller.extend(ClassMethods) 
      end
      
      attr_reader :xiaonei_session 
      
      def set_xiaonei_session
        @xiaonei_session ||= Session.new(params)
      end
      
      module ClassMethods
        def acts_as_xiaonei_controller
          before_filter :set_xiaonei_session
        end
      end
    end
  end
end
