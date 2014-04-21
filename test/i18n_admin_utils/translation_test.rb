require 'test_helper'

module I18nAdminUtils
  class TranslationTest < ActiveSupport::TestCase

    def setup
      setup_i18n_backend
    end

    ################################################
    # Test missing_translation?
    ################################################
    test 'Should be missing a translation(nil)' do
      translation = Translation.new('mykey')
      translation.translations = {:en => 'Translated!', :fr => nil}
      assert translation.missing_translation?
    end

    test 'Should be missing a translation(empty)' do
      translation = Translation.new('mykey')
      translation.translations = {:en => 'Translated!', :fr => ''}
      assert translation.missing_translation?
    end

    test 'Should not be missing a translation' do
      translation = Translation.new('mykey')
      translation.translations = {:en => 'Translated!', :fr => 'Also translated!'}
      assert !translation.missing_translation?
    end

    ################################################
    # Test missing_translation?
    ################################################
    test 'Create from hash with locations in array' do
      locations = [{:filename => 'filename1'}, {:filename => 'filename2'}]
      translation = Translation.from_hash({:key => 'mykey', :locations => locations})
      assert translation.locations.size == locations.size, "Should have #{locations.size} locations but have #{translation.locations.size}"
      locations.each do |location|
        assert translation.locations.include? location
      end
    end

    test 'Create from hash with locations in hash' do
      locations = {0 => {:filename => 'filename1'}, 1 => {:filename => 'filename2'}}
      translation = Translation.from_hash({:key => 'mykey', :locations => locations})
      assert translation.locations.size == locations.size, "Should have #{locations.size} locations but have #{translation.locations.size}"
      locations.each do |k, location|
        assert translation.locations.include? location
      end
    end
  end
end