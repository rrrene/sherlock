#!/usr/bin/env ruby -wKU

module Detective
  module Collection
    class Lines < Base
      # Executes gsub on all lines in the collection and returns
      # the modified collection.
      def gsub(*args, &block)
        arr = map { |line| line.gsub(*args, &block) }
        new(arr)
      end
    
      # Returns an array of the lines' match_data objects without the 
      # 'overall' match (the first element of the MatchData object).
      def matches
        map { |line| line.match_data[1..line.match_data.length-1] }
      end
      
      def new(arr, opts = {}) # :nodoc:
        self.class.new(arr)
      end
      
      def save!
        sort_by { |line| line.line_number }.reverse.each(&:save!)
      end
      
      def to_s
        map { |line| (line.changed? ? '[C] ' : '[ ] ') + line.inspect }.join("\n")
      end
      alias inspect to_s
    end
  end
end