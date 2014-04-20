require 'coveralls'
Coveralls.wear!

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path("../dummy/config/environment.rb", __FILE__)
require 'rails/test_help'
require 'dummy/config/environment'

Rails.backtrace_cleaner.remove_silencers!

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

# Load fixtures from the engine
if ActiveSupport::TestCase.method_defined?(:fixture_path=)
  ActiveSupport::TestCase.fixture_path = File.expand_path("../fixtures", __FILE__)
end

require 'rails/generators/test_case'

class ActiveSupport::TestCase

  def i18n_backend_folder
    File.expand_path('tmp/yml', __FILE__)
  end

  def setup_i18n_backend
    I18n.backend = I18n::Backend::Simple.new
    I18n.load_path = Dir[Rails.root.join(i18n_backend_folder, '*.{rb,yml}').to_s]
    I18n.enforce_available_locales = false
    I18n.backend.reload!
  end
  def reload_i18n_path
    I18n.load_path += Dir[Rails.root.join(File.expand_path('../../tmp/yml', __FILE__), '*.{rb,yml}').to_s]
  end
end