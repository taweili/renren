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
        [ Xiaonei::Error, 
          Xiaonei::User,
          Xiaonei::HometownLocation,
          Xiaonei::WorkInfo,
          Xiaonei::HsInfo,
          Xiaonei::ContactInfo,
          Xiaonei::UniversityInfo ]
      end

      def elm_name_to_class(name)
        @name_to_class ||= Hash[*(model_classes.collect {|v| [v.elm_name, v]}.flatten)]
        @name_to_class[name]
      end
      
      def attr_name?(name)
        unless @attr_names
          @attr_names = []
          model_classes.each { |k| @attr_names += k.attr_names }
        end
        @attr_names.include?(name.to_sym)
      end
      
      def initialize
        @stack = TotalArray.new
        elm_name_to_class("foo")
        attr_name?("foo")
      end

      def tag_start(name, attrs)
        pp "tag_start --- #{name} --- #{attrs.inspect} --- #{@stack.inspect}"
        if k = elm_name_to_class(name)
          @stack.push(k.new)
        elsif attr_name?(name)
          @stack.push("#{name}=".to_sym)
        end
        if attrs["list"] == "true"
          @stack.push TotalArray.new
        end
      end

      def tag_end(name)
        pp "tag_end --- #{name} --- #{@stack.inspect}"
        @result = @stack.pop
        if @stack.last.kind_of? Symbol
          if @stack.last
            s = @stack.pop
            if @stack.last.respond_to? s
              @stack.last.send(s, @result)
            else
              pp "unknown attribute #{s}"
            end
          end
        elsif @result.kind_of? Array and @stack.size > 0
          s = @stack.pop
          @stack.last.send(s,@result)
        elsif @result.instance_of?(Symbol)
          if @stack.last.respond_to? @result
            @stack.last.send(@result, nil)
          else
            pp "unknown attribute #{@result}"
          end
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
