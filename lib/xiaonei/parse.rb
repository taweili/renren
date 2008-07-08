require 'rexml/document'
require 'rexml/streamlistener'
require 'pp'

module Xiaonei
  class Parse
    DEBUG = false
    class MyListener
      include REXML::StreamListener
      attr_accessor :result

      class TotalArray < Array
        attr_accessor :total
        def self.is_array?
          true
        end
      end
      
      class UidArray < Array
        def uid=(id)
          self << id
        end
        def self.is_array?
          true
        end
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
         Xiaonei::UniversityInfo,
         Xiaonei::Album,
         Xiaonei::Messages,
         Xiaonei::Blogs,
         Xiaonei::Blog,
         Xiaonei::Photo,
         Xiaonei::GuestRequests,
         Xiaonei::Guest,
         Xiaonei::Poke,
         Xiaonei::WallPosts,
         Xiaonei::WallPost,
         Xiaonei::Comment
        ]
      end
      
      def array_elements
        { 
          "friends_getAppUsers_response" => UidArray,
          "requests_sendRequest_response" => UidArray,
          "feed_publishTemplatizedAction_response" => TotalArray,
          "profile_setXNML_response" => TotalArray
        }
      end
      
      def elm_name_to_class(name)
        @name_to_class ||= Hash[*(model_classes.collect {|v| [v.elm_name, v]}.flatten)].merge!(array_elements)
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
        pp("  tag_start[begin] --- #{name} --- #{attrs.inspect} --- #{@stack.inspect}") if DEBUG
        
        s_size = @stack.size
        if k = elm_name_to_class(name)
          @stack.push(k.new)
        elsif attr_name?(name)
          @stack.push("#{name}=".to_sym)
        end
        
        if attrs["list"] == "true"
          unless elm_name_to_class(name) and elm_name_to_class(name).is_array?
            @stack.push TotalArray.new
          end
        end

        if @stack.size == s_size # nothing get push to stack
          pp "unknown tag #{name}"
          @stack.push :no_op
        end
        
        pp("  tag_start[end] --- #{name} --- #{attrs.inspect} --- #{@stack.inspect}") if DEBUG
      end

      def tag_end(name)
        pp("  tag_end[begin] --- #{name} --- #{@stack.inspect}") if DEBUG
        
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
        
        pp("  tag_end[end] --- #{name} --- #{@stack.inspect} --- #{@result}") if DEBUG
      end
      
      def text(text)
        if (t = text.strip) != ""
          @stack.push t
        end
      end
      
      def cdata(data)
        text(data)
      end
      
    end

    def process(data)
      listener = MyListener.new
      pp("  parse --- #{data}") if DEBUG
      REXML::Document.parse_stream(data, listener)
      listener.result
    rescue Exception => e
      pp e
      nil
    end
  end
end
