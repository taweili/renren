require 'renren'
module Renren
  module Rails
    module Controller
      def self.included(controller)
        controller.extend(ClassMethods) 
      end
      
      attr_reader :renren_session 
      
      def set_renren_session
        session_set = session_already_secured?
        
        unless session_set
          session_set = create_renren_session
          session[:renren_session] = @renren_session if session_set
        end
        
        session_set
      end
      
      private
      
      def create_renren_session
        secure_with_renren_params! || secure_with_cookies!
      end
      
      def secure_with_cookies!
        parsed = {}

        xn_cookie_names.each { |key| parsed[key[xn_cookie_prefix.size, key.size]] = cookies[key] }
        
        #returning gracefully if the cookies aren't set or have expired
        return unless parsed['session_key'] && parsed['user'] && parsed['expires'] && parsed['ss'] 
        return unless (Time.at(parsed['expires'].to_s.to_f) > Time.now) || (parsed['expires'] == "0")
        #if we have the unexpired cookies, we'll throw an exception if the sig doesn't verify
        verify_signature(parsed, cookies[Renren.api_key], true)


        @renren_session = Renren::Session.new(parsed)
        @renren_session
      end
      
      def secure_with_renren_params!
        # TODO: I am not sure about renren params
        return unless request_comes_from_renren?
        
        if ['user', 'session_key'].all? {|element| renren_params[element]}
          @renren_session = Session.new(params)
          @renren_session
        end
      end
      
      def request_comes_from_renren?
        request_is_for_a_renren_canvas? || request_is_xn_ping?
      end
      
      def request_is_xn_ping?
        !params['xn_sig'].blank?
      end
      
      def request_is_for_a_renren_canvas?
        !params['xn_sig_in_canvas'].blank?
      end
      
      def xn_cookie_names
        xn_cookie_names = cookies.keys.select {|k| k && k.starts_with?(xn_cookie_prefix)}
      end

      def xn_cookie_prefix
        Renren.api_key + "_"
      end
      
      def session_already_secured?
        (@renren_session = session[:renren_session]) && session[:renren_session].secured?
      end
      
      def renren_params
        @renren_params ||= verified_renren_params
      end
      
      def verified_renren_params
        # TODO: verify renren_params for canvas
        renren_sig_params = params.inject({}) do |collection, pair|
          collection[pair.first] = pair.last if pair.first[0,7] == 'xn_sig_'
          collection
        end
      end
      
      def verify_signature(renren_sig_params, expected_signature, force=false)
        # Not use rack yet.
        # Don't verify the signature if rack has already done so.
        # unless ::Rails.version >= "2.3" and ActionController::Dispatcher.middleware.include? Rack::Facebook and !force
          raw_string = renren_sig_params.map{ |*args| args.join('=') }.sort.join
          actual_sig = Digest::MD5.hexdigest([raw_string, Renren.secret_key].join)
          raise Renren::Session::IncorrectSignature if actual_sig != expected_signature
        # end
        raise Renren::Session::SignatureTooOld if renren_sig_params['time'] && Time.at(renren_sig_params['time'].to_f) < earliest_valid_session
        true
      end
      
      module ClassMethods
        def acts_as_renren_controller
          before_filter :set_renren_session
        end
      end
    end
  end
end
