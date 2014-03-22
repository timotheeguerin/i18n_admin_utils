module I18nAdminUtils
  class SearchTranslation
    #Regex that match plain text in html
    HTML_PLAIN_TEXT_REGEX =  /(?<=>)(([^><])+)(?=<)/

    def self.search
      results = find_translation
      check_results(results)
    end

    def self.find_translation
      results = []
      dirs = I18nAdminUtils::Config.search_folders
      dirs.each do |dir|
        Dir.glob("#{dir}/**/*.*").each do |filename|
          File.open(filename).read.scan(/t\(("(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*')\)/).each do |result|
            key = result[0][1...-1]
            results << key
          end
        end
      end
      results
    end

    def self.check_results(results)
      missing = []
      results.each do |result|
        I18nAdminUtils::Config.locales.each do |locale|
          if I18nAdminUtils::Config.translation_model.where(:locale => locale, :key => result).first.nil?
            missing << {:locale => locale, :key => result}
          end
        end
      end
      missing
    end

    def self.find_plain_text
      results = SearchResult.new
      dirs = I18nAdminUtils::Config.search_folders
      dirs.each do |dir|
        Dir.glob("#{dir}/**/*.*").each do |filename|
          results[filename] = find_plain_text_in_file(filename)
        end
      end
      results
    end

    def self.find_plain_text_in_file(filename)
      list = []
      File.open(filename).read.scan(HTML_PLAIN_TEXT_REGEX).each do |result|
        list << result[0] unless result[0].blank?
      end
      list
    end
  end
end