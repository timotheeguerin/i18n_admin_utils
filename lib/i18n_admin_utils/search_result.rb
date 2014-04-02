module I18nAdminUtils
  class SearchResult
    attr_accessor :results

    def initialize(array= [])
      @results = array
    end

    def size
      @results.size
    end

    def [](i)
      @results[i]
    end

    def []=(i, hash)
      @results[i]= hash
    end

    def <<(hash)
      @results << hash
    end

    def +(other)
      SearchResult.new(@results + other.results)
    end

    def include_key?(key)
      @results.any? { |h| h[:key] == key }
    end

    def each(&block)
      @results.each(&block)
    end

    def delete(element)
      @results.delete(element)
    end

    def to_s
      @results.to_s
    end
  end
end