I18nAdminUtils.config do |config|

  #Model that contains the translation must have locale, key and value columns
  config.translation_model = Translation

  #Reload the translation after they have been updated
  config.reload_translation_after_update = true
end