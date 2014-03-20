require 'test_helper'

class TestTranslationModel

end

class ConfigTest < ActionView::TestCase
  tests I18nAdminUtils::Config

  test 'Test translation model if given string' do
    I18nAdminUtils::Config.translation_model='TestTranslationModel'
    assert I18nAdminUtils::Config.translation_model == TestTranslationModel
  end

  test 'Test translation model if given model' do
    I18nAdminUtils::Config.translation_model=TestTranslationModel
    assert I18nAdminUtils::Config.translation_model == TestTranslationModel
  end
end
