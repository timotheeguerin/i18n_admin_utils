require 'test_helper'
class I18nAdminUtils::TranslationControllerTest < ActionController::TestCase
  tests I18nAdminUtils::TranslationController

  def destination
    File.expand_path('../../tmp/yml', __FILE__)
  end

  def filename
    File.join(destination, 'test_yml')
  end
  def setup
   # FileUtils.rm_rf(destination)
    I18n.backend = I18n::Backend::Simple.new
    I18n.backend.reload!
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'ajax should add translation with locale and key seperate' do
    I18nAdminUtils::Config.reset
    I18nAdminUtils::Config.yml_file = filename
    locale = 'en'
    key = 'testkey.testsubkey'
    value = 'Super value!'
    xhr :get, :edit, :locale => locale, :key => key, :value => value
    assert JSON.parse(@response.body)['success'], "Response should be 'success' but is #{@response.body}"
    assert I18n.t(key, :locale => locale) == value, 'Translation should have been added'
  end

end