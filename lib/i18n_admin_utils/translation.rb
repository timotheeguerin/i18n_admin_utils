module I18nAdminUtils
  class Translation
    attr_accessor :key
    attr_accessor :location
    attr_accessor :translations

    def initialize(key, location = nil)
      @key = key
      @translations = {}
      @location = []
      @location << location unless location.nil?
      load_translation
    end

    def load_translation
      @translations = {}
      I18nAdminUtils::Config.locales.each do |locale|
        @translations[locale] = I18n.t(key, :locale => locale, :default => nil)
      end
    end

    #Return list of the untranslated locales
    def missing_translations
      @translations.select { |x, v| v.nil? }
    end

    #Return boolean if at least on translation is missing
    def missing_translation?
      @translations.each do |k, v|
        return true if v.nil?
      end
      false
    end
  end
end
