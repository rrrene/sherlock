#!/usr/bin/env ruby -wKU

module Detective
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
    end
  end
end