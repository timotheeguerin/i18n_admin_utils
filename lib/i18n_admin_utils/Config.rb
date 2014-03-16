require 'active_support/core_ext/module/attribute_accessors'

module I18nAdminUtils
  module Config
    class << self
      attr_accessor :translation_model
    end
  end
end