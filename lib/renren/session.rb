require 'digest/md5'

module Renren
  class Session
    class IncorrectSignature < Exception; end
    class SessionExpired < Exception; end
    class OtherException < Exception; end
  
    attr_accessor :auth_token
    attr_reader :session_key
    attr_reader :expires
    attr_reader :uid
    attr_reader :time
    attr_reader :api_key
    attr_reader :in_iframe
    attr_reader :added

    def initialize(options)
      initialize_by_canvas(options) || initialize_by_connect(options)
    end
    
    def initialize_by_canvas(options)
      if options["xn_sig_session_key"]
        @expires = options["xn_sig_expires"] == "1"
        @session_key = options["xn_sig_session_key"]
        @uid = options["xn_sig_user"]
        @time = options["xn_sig_time"]
        @api_key = options["xn_sig_api_key"]
        @in_iframe = options["xn_sig_in_iframe"] == "1"
        @added = options["xn_sig_added"] == "1"
      end
    end
    
    def initialize_by_connect(options)
      if options['session_key']
        @expires = options['expires'] ? Integer(options['expires']) : 0
        @session_key = options['session_key']
        @uid = options['user']
        @secret_from_session = options["ss"]
      end
    end
    
    def user
      @user ||= invoke_method("xiaonei.users.getInfo", :uids => @uid, :fields => Renren::User.attr_names.join(",")).first
    end
    
    def infinite?
      @expires == 0
    end

    def expired?
      @expires.nil? || (!infinite? && Time.at(@expires) <= Time.now)
    end

    def secured?
      !@session_key.nil? && !expired?
    end
    
    def compute_sig(params)
      str = params.collect {|k,v| "#{k}=#{v}"}.sort.join("") + Renren.secret_key
      str = Digest::MD5.hexdigest(str)
    end

    def invoke_method(method, params = {})
      xn_params = {
        :method => method,
        :api_key => Renren.api_key,
        :session_key => session_key,
        :call_id => Time.now.to_i,
        :v => "1.0" }
      xn_params.merge!(params) if params
      Parse.new.process(Service.new.post(xn_params).body)
    end

  end
end
