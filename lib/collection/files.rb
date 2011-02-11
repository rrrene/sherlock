#!/usr/bin/env ruby -wKU

module Sherlock
  module Collection
    class Files < Base
  
      def initialize(glob_or_regex, opts = {})
        case glob_or_regex
        when Hash
          opts = glob_or_regex
        when Array
          opts[:arr] = glob_or_regex
        when String
          opts[:glob] = glob_or_regex
        when Regexp
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
        select_files(pattern, :select)
      end
      alias containing select_files_containing

      # Returns a FileCollection with all files not containing the
      # given content / matching the given pattern.
      def select_files_not_containing(pattern)
        select_files(pattern, :reject)
      end
      alias not_containing select_files_not_containing

      private

      def select_files(pattern, method)
        pattern = [pattern].flatten
        arr = send(method) { |f| matching?(File.read(f), pattern) }
        new(arr)
      end
    end
  end
end
