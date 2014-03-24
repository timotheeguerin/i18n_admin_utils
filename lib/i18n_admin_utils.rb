require 'i18n_admin_utils/engine'
require 'i18n_admin_utils/config'
require 'i18n_admin_utils/search_translation'
require 'i18n_admin_utils/search_result'
require 'i18n_admin_utils/yml_manager'

module I18nAdminUtils
  def self.config(&block)
    if block_given?
      block.call(I18nAdminUtils::Config)
    else
      I18nAdminUtils::Config
    end
  end
end
