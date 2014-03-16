module I18nAdminUtils
  class ApplicationController < ::ApplicationController
    protect_from_forgery with: :exception
    layout 'layouts/application'
  end
end
