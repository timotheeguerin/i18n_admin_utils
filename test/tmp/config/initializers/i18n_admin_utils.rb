I18nAdminUtils.config do |config|

  #Model that contains the translation must have locale, key and value columns
  config.translation_model = Translation

  #Reload the translation after they have been updated
  config.reload_translation_after_update = true

  #List of locales used in your application
  config.locales = ['en']


  #List of folder where the app will look for the use of the t() method
  config.search_folders = ["#{Rails.root}/app"]

  #Yml files if you are using a yml backend
  config.yml_file = "#{Rails.root}/config/locale/i18_admin_utils"

  #To exclude some folder included in the search_folders
  #Not working yet!
  #config.search_folders_exclude = []
end