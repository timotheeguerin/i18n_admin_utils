module I18nAdminUtils
  class SearchTranslation
    def self.search
      results = []
      dirs = ["#{Rails.root}/app"]
      dirs.each do |dir|
        Dir.glob("#{dir}/**/*.*").each do |filename|
          File.open(filename).read.scan(/t\(("(?:\\.|[^"\\])*"|'(?:\\.|[^'\\])*')\)/).each do |result|
            results << result[0][1...-1]
          end
        end
      end
      check_results(results)
    end

    def self.check_results(results)
      missing = []
      results.each do |result|
        locale = 'en'
        if I18nAdminUtils::Config.translation_model.where(:locale => locale, :key => result).first.nil?
          missing << {:locale => locale, :key => result}
        end
      end
      missing
    end
  end
end