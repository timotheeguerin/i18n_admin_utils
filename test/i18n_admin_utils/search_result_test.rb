require 'test_helper'

module I18nAdminUtils
  class SearchResultTest < ActiveSupport::TestCase

    def setup
      setup_i18n_backend
    end

    test 'Test []= works' do
      results = SearchResult.new
      test_position = [2, 4, 3, 0]

      test_position.each do |position|
        results[position] = Translation.new("mykey#{position}", 'filename')
      end

      test_position.each do |position|
        assert !results.results[position].nil?, "Expecting translation at position #{position} but empty"
        key = "mykey#{position}"
        assert results.results[position].key = key, "Excpecting key to be #{key} but is #{results.results[position].key}"
      end
    end

    test 'Test [] works' do
      results = SearchResult.new
      results[3]= Translation.new('mykey', 'filename')
      assert !results[3].nil?
      assert results[3].key == 'mykey'
    end

    test 'Test merge same key' do
      result = SearchResult.new
      filenames = %w(filename filename2)
      filenames.each do |filename|
        result << Translation.new('mykey', filename)
      end
      assert result.size == 1, "The result should be 1 but is #{result.size}"
      locations = result.first.locations
      assert locations.size == filenames.size, "The result should be #{filenames.size} locations but has #{locations.size}"
      filenames.each do |filename|
        assert locations.include?(filename)
      end
    end

    test 'Test dont merge same file, different keys' do
      results = SearchResult.new
      keys = %w(mykey1 mykey2)
      keys.each do |key|
        results << Translation.new(key, 'filename')
      end
      assert results.size == keys.size, "The result should be #{keys.size} but is #{results.size}"
      keys.each do |key|
        assert results.include_key?(key), "Results should include key `#{key}`!"
      end
    end
  end
end