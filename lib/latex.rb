#!/usr/bin/env ruby -wKU

# this is still very experimental
#
# I want to be able to perform large LaTeX document analysis in an easy readable way
# e.g. 
#   Sherlock[:tex].inputs(:except => 'generated') 
#     # => all lines with input directives, except the ones containing 'generated'
#   Sherlock[:tex].macros(:emph)
#     # => all lines containing the \emph{} macro
#
#  Maybe even environments could be analysed (e.g. figure and tabular)
#
module Sherlock
  module LaTex #:nodoc:
    class << self
      def included(base)
        base.__send__(:include, InstanceMethods)
        Sherlock::Collection::Files.__send__(:include, Collection::Files::InstanceMethods)
      end
    end
    
    module InstanceMethods
      def tex_files(opts = {})
        investigate('**/*.tex', opts)
      end
    end
    
    module Collection
      module Files
        module InstanceMethods
          def collect_macros(pattern)
            collect(/\\(#{pattern})(\{([^\}]+)\})*/)
          end
          alias macros collect_macros
      
          def inputs(opts = {})
            macros(:input).filter(opts)
          end
      
          def tagged(with_tag)
            tag_prefix = "%%!!"
            arr = [with_tag].flatten.map { |tag| "#{tag_prefix} #{tag}" }
            containing(arr)
          end
    
          def not_tagged(with_tag)
            tag_prefix = "%%!!"
            arr = [with_tag].flatten.map { |tag| "#{tag_prefix} #{tag}" }
            not_containing(arr)
          end
        end
      end
    end
  end
end