#!/usr/bin/env ruby -wKU

module Detective
  module Collection
    class Lines < Base
      # Executes gsub on all lines in the collection and returns
      # the modified collection.
      def gsub(*args, &block)
        arr = map { |line|
          str = line.gsub(*args, &block)
          MatchedLine.new(str, line.attributes)
        }
        new(arr)
      end
    
      # Returns an array of the lines' match_data objects without the 
      # 'overall' match (the first element of the MatchData object)
      def matches
        map { |line| line.match_data[1..line.match_data.length-1] }
      end
      
      def new(arr, opts = {}) # :nodoc:
        self.class.new(arr)
      end
    
      def to_s
        map { |line| line.inspect }.join("\n")
      end
      alias inspect to_s
    end
  end
end