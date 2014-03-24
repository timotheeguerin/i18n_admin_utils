module I18nAdminUtils
  module Backend
    class Manager
      def self.save_translation(locale, key, translation)
        puts 'saving: ' +translation
        I18nAdminUtils::Config.backend.save_translation(locale, key, translation)
        I18n.backend.reload! if I18nAdminUtils::Config.reload_translation_after_update
      end
    end
  end
end