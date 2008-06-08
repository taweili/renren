require 'rexml/document'
require 'rexml/streamlistener'
require 'pp'

module Xiaonei
  class Parse
    class DataArray < Array
      attr_accessor :element_name
      def initialize(name)
        @element_name = name
      end
    end
    
    class MyListener
      include REXML::StreamListener
      attr_accessor :result
      
      NAME_CLASSES = { 
        "error_response" => Xiaonei::Error, 
        "user" => Xiaonei::User,
        "hometown_location" => Xiaonei::HometownLocation,
        "work_info" => Xiaonei::WorkInfo
      }
      
      def initialize
        @stack = Array.new
      end

      def tag_start(name, attrs)
        pp "tag_start --- #{name} --- #{attrs.inspect} --- #{@stack.inspect}"
        
        if attrs["list"] == "true"
          @stack.push(DataArray.new(name))
        else
          @name = name
          unless NAME_CLASSES[@name].nil?
            @stack.push(NAME_CLASSES[@name].new)
          end
        end
      end

      def tag_end(name)
        pp "tag_end --- #{name} --- #{@stack.inspect}"
        unless NAME_CLASSES[name].nil?
          @result = @stack.pop
          if @stack.last.instance_of? Array
            @stack.last.push @result
          elsif @stack.last == :assign
            @stack.pop
            attr_name = @stack.pop
            @stack.last.send("#{@name}=".to_sym, @result)
          end
        end
      end
      
      def text(text)
        if @name and @stack.last.respond_to?(:has_attr?) and @stack.last.has_attr?(@name)
          pp "text --- #{@stack.last.inspect} --- #{@name} --- #{text}"
          @stack.last.send("#{@name}=".to_sym, text.strip)
          @name = nil
        end
      end
    end

    def process(data)
      listener = MyListener.new
      REXML::Document.parse_stream(data, listener)
      listener.result
    end
  end
end
