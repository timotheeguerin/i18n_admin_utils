require 'test_helper'
#tests I18nAdminUtils::SearchTranslation
class SearchTranslationTest < ActiveSupport::TestCase


  def destination
    File.expand_path('../../tmp/translation_use', __FILE__)
  end

  setup do
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
    filename = File.join(destination, "p_#{@plain_text.size}_use.rb")
    file = File.new(filename, 'w')
    @plain_text.each do |text|
      file.puts "<div>#{text}</div>"
    end
    file.close
  end

  test 'Find all the translations' do
    results = I18nAdminUtils::SearchTranslation.find_translation
    puts 'T: ' + results.to_s
    assert @translations.size == results.size, "Found different amount of translation: #{results.size} instead of #{@translations.size}"

    @translations.each do |translation|
      assert results.include?(translation), "Error translation #{translation} not found"
    end
  end


  test 'Find all the plain text' do
    results = I18nAdminUtils::SearchTranslation.find_plain_text
    puts '*-------R: ' + results.to_s
    assert @plain_text.size == results.total_found, "Found different amount of translation: #{results.total_found} instead of #{@plain_text.size}"

    @plain_text.each do |text|
      assert results.include?(text), "Error plain text #{text} not found"
    end
  end



end