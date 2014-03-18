require 'active_support/core_ext/module/attribute_accessors'

module I18nAdminUtils
  module Config
    class << self
      attr_accessor :translation_model
      attr_accessor :reload_translation_after_update
      attr_accessor :locales

      def reset
        @translation_model = 'Translation'
        @reload_translation_after_update = true
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