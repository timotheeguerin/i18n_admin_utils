require 'test_helper'
module I18nAdminUtils
  class YmlManagerTest < ActiveSupport::TestCase
    def destination
      File.expand_path('../../tmp/yml', __FILE__)
    end

    def filename
      File.join(destination, 'test_tml')
    end

    def setup
    end

    test 'File should be created' do
      I18nAdminUtils::Config.yml_file = filename
      yml = I18nAdminUtils::YmlManager.parse_yml('en')
      assert File.exists?("#{filename}.en.yml"), "Expected file #{filename}.en.yml to exist, but does not"
      assert yml, "Yml was not parsed: #{yml}"
    end

    test 'Translation should be added' do
      I18n.backend = I18n::Backend::Simple.new
      I18n.backend.reload!
      I18n.load_path += Dir[Rails.root.join(destination, '*.{rb,yml}').to_s]
      I18nAdminUtils::Config.yml_file = filename
      key = 'test.dumb.blabl'
      locale = 'en'
      translation = 'Dumbtranslation'
      I18nAdminUtils::YmlManager.save_translation(locale, key, translation)
      assert translation == I18n.t(key), "Translation should be #{translation} but is #{I18n.t(key)}"
    end
  end
end