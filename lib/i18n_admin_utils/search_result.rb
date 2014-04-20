module I18nAdminUtils
  class SearchResult
    attr_accessor :results

    def initialize(array= [])
      @results = array
    end


    def [](i)
      @results[i]
    end

    def []=(i, translation)
      existing = find_by_key(translation.key)
      if existing.nil?
        if i == -1
          @results << translation
        else
          @results[i] = translation
        end
      else
        existing.locations += translation.locations
      end
    end

    def <<(translation)
      self[-1] = translation
    end

    def +(other)
      SearchResult.new(@results + other.results)
    end

    def find_by_key(key)
      @results.select { |h| not h.nil? and h.key == key }.first
    end

    def include_key?(key)
      @results.any? { |h| not h.nil? and h.key == key }
    end


    def to_s
      @results.to_s
    end

    delegate :first, :last, :size, :each, :delete, :to => :results

    alias :count :size
  end
end