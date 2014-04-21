if defined? I18nAdminUtils and defined? I18nAdminUtils.config #Load the config only if the gem is required(development mode only)
  I18nAdminUtils.config do |config|

    #Specify the backend if you are using the chain(it will use the first one by default)
    #config.backend = 'I18n::Backend::Simple'
    #config.backend = 'I18n::Backend::ActiveRecord'

    #Model that contains the translation must have locale, key and value columns
    config.translation_model = Translation

    #Reload the translation after they have been updated
    config.reload_translation_after_update = true

    #List of locales used in your application
    config.locales = ['en']


    #List of folder where the app will look for the use of the t() method
    config.search_folders = ["#{Rails.root}/app"]

    #Yml files if you are using a yml backend
    config.yml_file = "#{Rails.root}/config/locales/i18_admin_utils"

    #To exclude some folder included in the search_folders
    #Not working yet!
    #config.search_folders_exclude = []
  end
end