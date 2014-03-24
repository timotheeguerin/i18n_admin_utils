module I18nAdminUtils
  module Backend
    class ActiveRecordManager
      def self.save_translation(locale, key, value)
        translation = I18nAdminUtils::Config.translation_model.where(:locale => locale, :key => key).first
        if translation.nil?
          translation = I18nAdminUtils::Config.translation_model.new
          translation.locale = locale
          translation.key = key
        end
        translation.value = value
        translation.save
      end
    end
  end
end