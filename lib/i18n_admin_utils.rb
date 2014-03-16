require 'i18n_admin_utils/engine'
require 'i18n_admin_utils/config'

module I18nAdminUtils
  def self.config(&block)
    if block_given?
      block.call(I18nAdminUtils::Config)
    else
      I18nAdminUtils::Config
    end
  end
end
