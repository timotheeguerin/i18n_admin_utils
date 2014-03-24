require 'test_helper'
class I18nAdminUtils::TranslationControllerTest < ActionController::TestCase
  tests I18nAdminUtils::TranslationController

  test 'should get index' do
    get :index
    assert_response :success
  end

end