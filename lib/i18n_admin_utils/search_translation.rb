module I18nAdminUtils
  class SearchTranslation
    #Regex that match plain text in html
    HTML_PLAIN_TEXT_REGEX = /(?<=>)(([^><])+)(?=<)/

    def self.search
      find_translation_usage
    end

    #Search for all t('') usage in the given directory
    def self.find_translation_usage
      results = SearchResult.new
      dirs = I18nAdminUtils::Config.search_folders
      dirs.each do |dir|
        Dir.glob("#{dir}/**/*.*").each do |filename|
          i = 1
          File.open(filename).each_line do |line|
            line.scan(/t\(("(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*')\)/).each do |result|
              key = result[0][1...-1]
              results << I18nAdminUtils::Translation.new(key, {:filename => filename, :line => i})
            end
            i += 1
          end

        end
      end
      results
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
        results << I18nAdminUtils::Translation.new(result[0], {:filename => filename}) unless result[0].blank?
      end
      results
    end
  end
end