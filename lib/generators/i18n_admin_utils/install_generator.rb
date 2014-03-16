require 'rails/generators'
module I18nAdminUtils
  class InstallGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)
    desc 'Creates a InstallGenerator initializer and copy locale files to your application.'
    def install
      route("mount I18nAdminUtils::Engine => '/', as: 'i18n_admin_utils'")
      template 'initializer.rb', 'config/initializers/i18n_admin_utils.rb'
    end
  end
end