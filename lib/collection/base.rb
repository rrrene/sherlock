#!/usr/bin/env ruby -wKU

module Detective
  module Collection
    class Base < Array
      # Returns the first value of the collection (matching the value, if given).
      def first(*value)
        item = if value.empty?
          super
        else
          filter(value)[0]
        end
        new([item])
      end
    
      # Returns a collection with all files matching the
      # given pattern.
      def select_items_matching(*pattern)
        opts = pattern.last.is_a?(Hash) ? pattern.pop : {}
        pattern = [pattern].flatten
        arr = select { |f| pattern.empty? || matching?(f, pattern) }
        arr = filter_array_by_options(arr, opts)
        new(arr, opts)
      end
      alias filter select_items_matching
  
      def [](value, *args)
        if value.is_a?(Regexp)
          filter(value, *args)
        else
          super(value)
        end
      end
    
      def -(other)
        new(super)
      end
    
      def +(other)
        new(super.uniq)
      end
    
      def &(other)
        new(super)
      end
    
      def |(other)
        new(super)
      end
    
      private

      def filter_array_by_options(arr, opts = {})
        arr = arr.select { |f| matching?(f, opts[:only]) } if opts[:only]
        arr = arr.reject { |f| matching?(f, opts[:except]) } if opts[:except]
        arr
      end

      def matching?(str, string_or_regexp_or_array)
        [string_or_regexp_or_array].flatten.each { |pattern|
          return true if str.match(pattern)
        }
        false
      end
    
      def new(*args)
        self.class.new(*args)
      end
    end
  end
end