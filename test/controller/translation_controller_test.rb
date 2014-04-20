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
    I18n.backend = I18n::Backend::Simple.new
    I18n.load_path = Dir[Rails.root.join(destination, '*.{rb,yml}').to_s]
    I18n.backend.reload!


    I18nAdminUtils::Config.reset
    I18nAdminUtils::Config.yml_file = filename
    I18nAdminUtils::Config.search_folders =[File.expand_path('../../tmp/translation_use', __FILE__)]
  end

  test 'should get index' do
    get :index
    assert_response :success
  end

  test 'ajax should add translation with locale and key seperate' do
    locale = 'en'
    key = 'testkey.testsubkey'
    value = 'Super value!'
    xhr :get, :edit, :locale => locale, :key => key, :value => value
    assert JSON.parse(@response.body)['success'], "Response should be 'success' but is #{@response.body}"
    assert I18n.t(key, :locale => locale) == value, 'Translation should have been added'
  end

  test 'ajax should add translation with locale and key joined' do
    locale = 'en'
    key = 'testkey.localandkeytogether'
    value = 'Super value!'
    xhr :get, :edit, :key => "#{locale}.#{key}", :value => value
    assert JSON.parse(@response.body)['success'], "Response should be 'success' but is #{@response.body}"
    assert I18n.t(key, :locale => locale) == value, 'Translation should have been added'
  end

  test 'should get missing list' do
    I18n.backend.reload!
    get :missing_list
    assert_response :success
  end

  test 'should return error message when no params given' do
    get :list_element
    assert_response :success
    assert response.body.include?('Error')
  end

  test 'should return error message when no key given' do
    get :list_element, :translation => {}
    assert_response :success
    assert response.body.include?('Error')
  end

  test 'should get list element with no locations' do
    get :list_element, :translation => {:key => 'mykey', :locations => []}
    assert_response :success
  end

  test 'should get list element with one locations' do
    get :list_element, :translation => {:key => 'mykey', :locations => [{:filename => 'filename'}]}
    assert_response :success
  end

  test 'should get list element with mutliple locations' do
    get :list_element, :translation => {:key => 'mykey', :locations => [{:filename => 'filename1'}, {:filename => 'filename2'}]}
    assert_response :success
  end
end