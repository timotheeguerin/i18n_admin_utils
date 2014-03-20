require 'active_support/core_ext/module/attribute_accessors'

module I18nAdminUtils
  module Config
    class << self
      attr_accessor :translation_model
      attr_accessor :reload_translation_after_update
      attr_accessor :locales
      attr_accessor :search_folders
      attr_accessor :search_folders_exclude

      def reset
        @translation_model = 'Translation'
        @reload_translation_after_update = true
        @locales = ['en']
        @search_folders = ["#{Rails.root}/app"]
        @search_folders_exclude = []
      end


      def translation_model
        if @translation_model.is_a? String
          @translation_model.constantize
        else
          @translation_model
        end
      end


      #Set the default values
    end
    reset
  end
end