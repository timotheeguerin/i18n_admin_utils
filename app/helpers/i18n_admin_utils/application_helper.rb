module I18nAdminUtils
  module ApplicationHelper

    #Show the number of translation missing with colorization
    def translation_missing_icon(translation)
      missing_translations = translation.missing_translations
      color_id = (missing_translations.size.to_f/translation.translations.size.to_f*5).ceil-1
      if missing_translations.size == 0
        content_tag 'span', '', :class => 'glyphicon glyphicon-ok greentext',
                    :title => 'This key has been translated in all languages', :rel => 'tooltip'
      else
        content_tag 'span', "(#{missing_translations.size})", :class => "color-range-#{color_id} bold",
                    :title => missing_translations.keys.join(','), :rel => 'tooltip'
      end
    end

    def translation_locations_compact_list(translation)
      if translation.locations.size == 0

        content_tag 'div', '', :class => 'translation_filename'
      elsif translation.locations.size == 1
        content_tag 'div', translation.locations.first[:filename].reverse, :class => 'translation_filename'
      else
        content = "#{translation.locations.first[:filename]} and #{translation.locations.size-1} more"
        title= translation.locations[1..-1].map { |x| "<div class='translation_filename'> #{x[:filename].reverse} </div>" }.join('')
        content_tag 'div', content.reverse, :class => 'translation_filename', :title => title, :rel => 'tooltip',
                    'data-html' => true
      end
    end
  end
end
