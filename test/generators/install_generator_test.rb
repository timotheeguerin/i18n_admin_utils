require 'test_helper'
require 'rails/generators'
require 'generators/i18n_admin_utils/install_generator'


class InstallGeneratorTest < Rails::Generators::TestCase
  tests I18nAdminUtils::InstallGenerator
  destination File.expand_path('../../tmp', __FILE__)

  setup do
    prepare_destination
    copy_routes
  end

  def copy_routes
    routes = File.expand_path('../../dummy/config/routes.rb', __FILE__)
    destination = File.join(destination_root, 'config')

    FileUtils.mkdir_p(destination)
    FileUtils.cp routes, destination
  end

  test 'Assert routes were properly created' do
    run_generator
    match = /mount I18nAdminUtils::Engine => '\/', as: 'i18n_admin_utils'/
    assert_file 'config/routes.rb', match
  end

  test 'Assert all files are properly created' do
    run_generator
    assert_file 'config/initializers/i18n_admin_utils.rb'
  end
end