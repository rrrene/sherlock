#!/usr/bin/env ruby -wKU

module Sherlock
  module Collection
    class Files < Base
  
      def initialize(glob_or_regex, opts = {})
        if glob_or_regex.is_a?(Hash)
          opts = glob_or_regex
        elsif glob_or_regex.is_a?(Array)
          opts[:arr] = glob_or_regex
        elsif glob_or_regex.is_a?(String)
          opts[:glob] = glob_or_regex
        elsif glob_or_regex.is_a?(Regexp)
          if opts[:only]
            raise "Cannot use regexp and :only-option at the same time."
          else
            opts[:only] = glob_or_regex
          end
        end
        opts = {:glob => '*'}.merge(opts)
        super(opts[:arr] || Dir[opts[:glob]], opts)
      end
  
      # Returns all the lines matching the given pattern.
      def collect_lines_matching(pattern, &block)
        pattern = [pattern].flatten
        lines = Lines.new
        self.each { |f|
          io = File.open(f)
          io.each { |line|
            if matching?(line, pattern)
              lines << MatchedLine.new(line, :file => f, :line_number => io.lineno, :pattern => pattern)
            end
          }
        }
        lines
      end
      alias old_collect collect
      alias collect collect_lines_matching
      alias lines collect_lines_matching
      
      # Returns a FileCollection with all files containing the
      # given content / matching the given pattern.
      def select_files_containing(pattern)
        pattern = [pattern].flatten
        arr = select { |f| matching?(File.read(f), pattern) }
        new(arr)
      end
      alias containing select_files_containing

      # Returns a FileCollection with all files not containing the
      # given content / matching the given pattern.
      def select_files_not_containing(pattern)
        pattern = [pattern].flatten
        arr = select { |f| !matching?(File.read(f), pattern) }
        new(arr)
      end
      alias not_containing select_files_not_containing
    end
  end
end