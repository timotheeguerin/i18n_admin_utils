require 'test_helper'
#tests I18nAdminUtils::SearchTranslation
class SearchTranslationTest < ActiveSupport::TestCase


  def destination
    File.expand_path('../../tmp/translation_use', __FILE__)
  end

  setup do
    @translations = ['translation1', 'test.translation2', 'super.super.translation3', 'test_pl.translation4']
    FileUtils.mkdir_p(destination)
    copy_translation_to_file()
    I18nAdminUtils::Config.search_folders = [destination]
  end

  def copy_translation_to_file
    filename = File.join(destination, "#{@translations.size}_use.rb")
    file = File.new(filename, 'w')
    @translations.each do |translation|
      file.puts "t('#{translation}')"
    end
    file.close
  end

  test 'Find all the translations' do
    results = I18nAdminUtils::SearchTranslation.find_transaltion
    puts 'R: ' + results.to_s
    assert @translations.size == results.size, "Found different amount of translation: #{results.size} instead of #{@translations.size}"

    @translations.each do |translation|
      assert results.include?(translation), "Error translation #{translation} not found"
    end
  end




end