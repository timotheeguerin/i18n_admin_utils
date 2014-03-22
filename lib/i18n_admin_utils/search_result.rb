module I18nAdminUtils
  class SearchResult
    attr_accessor :results

    def initialize(hash = {})
      @results = hash
    end

    def total_found
      @results.values.map{|x| x.size}.inject { |sum, x| sum + x }
    end

    def [](key)
      @results[key]
    end

    def []=(key, value)
      @results[key]= value
    end

    def include?(str)
      @results.values.flatten.include?(str)
    end
    def to_s
      @results.values.to_s
    end
  end
end