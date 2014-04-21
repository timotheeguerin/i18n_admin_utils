require 'test_helper'

class SearchTranslationTest < ActiveSupport::TestCase
  def destination
    File.expand_path('../../tmp/translation_use', __FILE__)
  end

  setup do
    setup_i18n_backend
    FileUtils.rm_rf(destination) #empty the dir
    @translations = ['translation1', 'test.translation2', 'super.super.translation3', 'test_pl.translation4']
    @plain_text = ['Hello', 'Welcome to this aswome werbsite', 'Blabla']
    FileUtils.mkdir_p(destination)
    copy_translation_to_file
    generate_plain_text
    I18nAdminUtils::Config.search_folders = [destination]
  end

  def copy_translation_to_file
    filename = File.join(destination, "t_#{@translations.size}_use.rb")
    file = File.new(filename, 'w')
    @translations.each do |translation|
      file.puts "t('#{translation}')"
    end
    file.close
  end

  def generate_plain_text
    filename = File.join(destination, "p_#{@plain_text.size}_use.erb")
    file = File.new(filename, 'w')
    @plain_text.each do |text|
      file.puts "<div>#{text}</div>"
    end
    file.close
  end

  test 'Find all the translations' do
    I18n.backend.reload!
    results = I18nAdminUtils::SearchTranslation.find_translation_usage
    assert @translations.size == results.size, "Found different amount of translation: #{results.size} instead of #{@translations.size}"

    @translations.each do |translation|
      assert results.include_key?(translation), "Error translation #{translation} not found"
    end
  end


  test 'Find all the plain text' do
    results = I18nAdminUtils::SearchTranslation.find_plain_text
    assert @plain_text.size == results.size, "Found different amount of translation: #{results.size} instead of #{@plain_text.size}"

    @plain_text.each do |text|
      assert results.include_key?(text), "Error plain text #{text} not found"
    end
  end
end