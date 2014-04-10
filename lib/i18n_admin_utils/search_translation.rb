module I18nAdminUtils
  class SearchTranslation
    #Regex that match plain text in html
    HTML_PLAIN_TEXT_REGEX = /(?<=>)(([^><])+)(?=<)/

    def self.search
      results = find_translation
      check_results(results)
    end

    def self.find_translation
      results = SearchResult.new
      dirs = I18nAdminUtils::Config.search_folders
      dirs.each do |dir|
        Dir.glob("#{dir}/**/*.*").each do |filename|
          i = 1
          File.open(filename).each_line do |line|
            line.scan(/t\(("(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*')\)/).each do |result|
              key = result[0][1...-1]
              results << {:key => key, :filename => filename, :line => i}
            end
            i += 1
          end

        end
      end
      results
    end

    def self.check_results(results)
      output = SearchResult.new
      results.each do |result|
        key = result[:key]
        I18nAdminUtils::Config.locales.each do |locale|
          if  I18n.t(key, :locale => locale, :default => 'empty') == 'empty'
            result[:locale] = locale
            output << result
          end
        end
      end
      output
    end

    def self.find_plain_text
      results = SearchResult.new
      dirs = I18nAdminUtils::Config.search_folders
      dirs.each do |dir|
        Dir.glob("#{dir}/**/*.*").each do |filename|
          results += find_plain_text_in_file(filename)
        end
      end
      results
    end

    def self.find_plain_text_in_file(filename)
      results = SearchResult.new
      File.open(filename).read.scan(HTML_PLAIN_TEXT_REGEX).each do |result|
        results << {:key => result[0], :filename => filename} unless result[0].blank?
      end
      results
    end
  end
end