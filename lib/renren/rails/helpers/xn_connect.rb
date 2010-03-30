module Renren
  module Rails
    module Helpers
      module XnConnect
        def xn_connect_javascript_tag
          "<script type='text/javascript' src='http://static.connect.renren.com/js/v1.0/FeatureLoader.jsp'></script>"
        end
        
        def init_xn_connect
          javascript_tag "XN_RequireFeatures(['EXNML'], function(){ XN.Main.init('#{Renren.api_key}', 'xd_receiver.html'); });"
        end
        
        def xn_login_button(options)
          content_tag("xn:login-button", nil, options)
        end
      end
    end
  end
end
