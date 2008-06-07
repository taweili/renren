require 'rexml/document'
require 'rexml/streamlistener'

module Xiaonei
  class Parse
    class MyListener
      include REXML::StreamListener
      attr_accessor :result
      def initialize
        @stack = Array.new
      end

      def tag_start(name, attrs)
        @name = name
        case name
        when "error_response"
          @stack.push(Error.new)
        end
      end
      def tag_end(name)
        case name
        when "error_response"
          @result = @stack.pop
        end
      end
      def text(text)
        @stack.last.send("#{@name}=".to_sym, text.strip)
      end
    end

    def process(data)
      listener = MyListener.new
      REXML::Document.parse_stream(data, listener)
    end
  end
end
