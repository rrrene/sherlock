#!/usr/bin/env ruby -wKU

module Sherlock
  module Collection
    
    # ==== Attributes
    # 
    # * <tt>:file</tt>
    # * <tt>:line_number</tt>
    # * <tt>:pattern</tt>
    #
    class MatchedLine < String
      attr_accessor :attributes

      def initialize(line, _attributes = {})
        super(line)
        self.attributes = {:original => line}.merge(_attributes)
      end
      
      def changed?
        attributes[:original] != self
      end
      
      def gsub(*args, &block)
        self.class.new(super, attributes)
      end
      
      def match_data
        attributes[:pattern].each do |p|
          if m = self.match(p)
            return m
          end
        end
        nil
      end
      
      def method_missing(m)
        if attributes && value = attributes[m.to_s.intern]
          value
        else
          super
        end
      end
      
      def save!
        all_lines = File.open(file, 'r') { |f| f.readlines }
        index = line_number - 1
        if original == all_lines[index]
          all_lines[index] = self.to_s
        else
          raise "File seems modified: #{file}"
        end
        File.open(file, 'w') {|f| f.write(all_lines) }
      end
    end
  end
end