module I18nAdminUtils
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception
    layout 'i18n_admin_utils/application'
  end
end
