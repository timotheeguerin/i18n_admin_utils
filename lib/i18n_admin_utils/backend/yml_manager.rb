module I18nAdminUtils
  module Backend
    class YmlManager
      def self.save_translation(locale, key, translation)
        yml = parse_yml(locale)
        yml[locale] ||= {}
        hash = yml
        last = locale
        key.split('.').each do |segment|
          hash[last] ||= {}
          hash = hash[last]
          last = segment
        end
        hash[last] = translation
        save(yml, locale)
      end

      def self.parse_yml(locale)
        filename = "#{I18nAdminUtils::Config.yml_file}.#{locale}.yml"
        create_file_if_not_exists(filename)
        yml = YAML.load(File.read(filename))
        yml = {} unless yml
        yml
      end

      def self.save(yml, locale)
        filename = "#{I18nAdminUtils::Config.yml_file}.#{locale}.yml"
        File.open(filename, 'w') { |f| f.write yml.to_yaml }
      end

      def self.create_file_if_not_exists(filename)
        dir = File.dirname(filename)

        unless File.directory?(dir)
          FileUtils.mkdir_p(dir)
        end

        File.new(filename, 'w') unless File.exist?(filename)
      end
    end
  end
end