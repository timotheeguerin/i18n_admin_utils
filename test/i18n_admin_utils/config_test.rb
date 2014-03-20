require 'test_helper'

class TestTranslationModel

end

#Tests I18nAdminUtils::Config
class ConfigTest < ActiveSupport::TestCase


  test 'Test translation model if given string' do
    I18nAdminUtils::Config.translation_model='TestTranslationModel'
    assert I18nAdminUtils::Config.translation_model == TestTranslationModel
  end

  test 'Test translation model if given model' do
    I18nAdminUtils::Config.translation_model=TestTranslationModel
    assert I18nAdminUtils::Config.translation_model == TestTranslationModel
  end

  test 'Load config fine with block' do
    I18nAdminUtils.config do |config|
      #Model that contains the translation must have locale, key and value columns
      config.translation_model = TestTranslationModel
    end

    assert I18nAdminUtils::Config.translation_model == TestTranslationModel
  end

  test 'Test config function without param' do
    assert I18nAdminUtils.config == I18nAdminUtils::Config
  end


end
