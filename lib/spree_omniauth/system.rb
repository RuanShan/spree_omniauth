require 'spree/core/controller_helpers/common'
# spree/api/base>action_base, spree/base>application
# both included controller_helper/store
class << Spree::Core::ControllerHelpers::Common
  def included_with_omniauth_support(receiver)
    included_without_omniauth_support(receiver)
    receiver.send :include, SpreeOmniauth::System
    receiver.send :wechat_api
    receiver.send :prepend_before_action, :initialize_wechat_account
    receiver.send :helper_method, :wechat_oauth2

  end
  alias_method_chain :included, :omniauth_support
end

module SpreeOmniauth
  module System
    private
    def initialize_wechat_account
      Rails.logger.debug "initialize_wechat_account"
      #self.wechat_api_client = load_controller_wechat(wechat_cfg_account, opts)
    end
  end
end
