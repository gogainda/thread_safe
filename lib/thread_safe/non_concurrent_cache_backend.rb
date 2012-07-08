module ThreadSafe
  class NonConcurrentCacheBackend
    # WARNING: all methods of the class must operate on the @backend directly without calling each other. This is important
    # because of the SynchronizedCacheBackend which uses a non-reentrant mutex for perfomance reasons.
    def initialize(options = nil)
      @backend = {}
    end

    def [](key)
      @backend[key]
    end

    def []=(key, value)
      @backend[key] = value
    end

    def put_if_absent(key, value)
      if @backend.key?(key)
        @backend[key]
      else
        @backend[key] = value
        nil
      end
    end

    def key?(key)
      @backend.key?(key)
    end

    def delete(key)
      @backend.delete(key)
    end

    def clear
      @backend.clear
      self
    end

    def each_pair
      @backend.each_pair do |k, v|
        yield k, v
      end
      self
    end
  end
end