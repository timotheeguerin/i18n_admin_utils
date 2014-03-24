require 'test_helper'
require 'i18n/backend/active_record'

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

  test 'test unique backend working' do
    backends = [I18n::Backend::Simple, I18n::Backend::ActiveRecord]
    backends.each do |backend|
      I18nAdminUtils::Config.backend = nil
      I18n.backend = backend.new
      result = I18nAdminUtils::Config.backend
      assert result == backend.to_s, "Wrong backend returned\n \t should have returned #{backend} \n\tbut returned #{result} "
    end
  end

  test 'test backend chain' do
    I18n.backend = I18n::Backend::Chain.new(I18n::Backend::ActiveRecord.new, I18n::Backend::Simple.new)
    I18nAdminUtils::Config.backend = nil
    result = I18nAdminUtils::Config.backend
    assert result == I18n::Backend::ActiveRecord.to_s, "Wrong backend returned\n \t should have returned #{I18n::Backend::ActiveRecord} \n\t but returned #{result} "
  end

  test 'test raise unsportted backend' do
    I18n.backend = TestTranslationModel.new
    assert_raise Exception do
      I18nAdminUtils::Config.backend = nil
      result = I18nAdminUtils::Config.backend
    end
  end


end
