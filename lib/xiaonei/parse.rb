require 'rexml/document'
require 'rexml/streamlistener'
require 'pp'

module Xiaonei
  class Parse
    class MyListener
      include REXML::StreamListener
      attr_accessor :result

      class TotalArray < Array
        attr_accessor :total
      end
      
      def model_classes
        [ 
         Xiaonei::Error, 
         Xiaonei::User,
         Xiaonei::HometownLocation,
         Xiaonei::WorkInfo,
         Xiaonei::HsInfo,
         Xiaonei::ContactInfo,
         Xiaonei::Friend,
         Xiaonei::UniversityInfo 
        ]
      end

      def elm_name_to_class(name)
        @name_to_class ||= Hash[*(model_classes.collect {|v| [v.elm_name, v]}.flatten)]
        @name_to_class[name]
      end
      
      def attr_name?(name)
        unless @attr_names
          @attr_names = []
          model_classes.each { |k| @attr_names += k.attr_names }
          @attr_names += [:total]
        end
        @attr_names.include?(name.to_sym)
      end
      
      def initialize
        @stack = TotalArray.new
        elm_name_to_class("foo")
        attr_name?("foo")
      end

      def tag_start(name, attrs)
        # pp "tag_start --- #{name} --- #{attrs.inspect} --- #{@stack.inspect}"
        
        s_size = @stack.size
        if k = elm_name_to_class(name)
          @stack.push(k.new)
        elsif attr_name?(name)
          @stack.push("#{name}=".to_sym)
        end
        if attrs["list"] == "true"
          @stack.push TotalArray.new
        end

        if @stack.size == s_size # nothing get push to stack
          pp "unknown tag #{name}"
          @stack.push :no_op
        end
        
      end

      def tag_end(name)
        # pp "tag_end --- #{name} --- #{@stack.inspect}"
        @result = @stack.pop
        if @result == :no_op
          #
        elsif @stack.last.kind_of? Symbol
          s = @stack.pop
          if s != :no_op
            @stack.last.send(s, @result)
          end
        elsif @result.kind_of? Array and @stack.size > 0
          s = @stack.pop
          @stack.last.send(s,@result)
        elsif @result.instance_of?(Symbol)
          @stack.last.send(@result, nil)
        elsif @stack.last.kind_of? Array
          @stack.last.push @result
        end
      end
      
      def text(text)
        if (t = text.strip) != ""
          @stack.push t
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
