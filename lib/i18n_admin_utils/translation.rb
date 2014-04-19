module I18nAdminUtils
  class Translation
    attr_accessor :key
    attr_accessor :locations
    attr_accessor :translations

    def initialize(key, location = nil)
      @key = key
      @translations = {}
      @locations = []
      @locations << location unless location.nil?
      load_translation
    end

    def self.from_hash(hash)
      translation = I18nAdminUtils::Translation.new(hash[:key])
      if hash[:locations].is_a? Array
        translation.locations = hash[:locations]
      elsif hash[:locations].is_a? Hash
        translation.locations = []
        hash[:locations].each do |k, v|
          translation.locations << v
        end
      end
      translation.translations = hash[:translations]
      translation
    end

    def load_translation
      @translations = {}
      I18nAdminUtils::Config.locales.each do |locale|
        @translations[locale] = I18n.t(key, :locale => locale, :default => '')
      end
    end

    #Return list of the untranslated locales
    def missing_translations
      @translations.select { |x, v| v.blank? }
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
