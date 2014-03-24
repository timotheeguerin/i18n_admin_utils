require 'coveralls'
Coveralls.wear!

# Configure Rails Environment
ENV['RAILS_ENV'] = 'test'

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
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
  def reload_i18n_path
    I18n.load_path += Dir[Rails.root.join(File.expand_path('../../tmp/yml', __FILE__), '*.{rb,yml}').to_s]
  end
end