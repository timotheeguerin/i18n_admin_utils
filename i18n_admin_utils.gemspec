$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'i18n_admin_utils/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'i18n_admin_utils'
  s.version     = I18nAdminUtils::VERSION
  s.authors     = ['Timothee Guerin']
  s.email       = %w(timothee.guerin@outlook.com)
  s.homepage    = 'http://github.com/timcolonel/i18n_admin_utils'
  s.summary     = 'Utils to help manage active record translation in a rails application'
  s.description = 'Utils to help manage active record translation in a rails application. It allow you to click on a untranslated key in your webpage to display a popover to translate this key. You can also get all the untranslated key in your application(More to come'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.0', '>=4.0.0'
  s.add_dependency 'json', '>= 0'
  s.add_dependency 'i18n-active_record', '>= 0'
  s.add_dependency 'bootstrap-sass', '~> 3.1.1', '~> 3.1.0'
  s.add_development_dependency 'sqlite3', '>= 0'
end
