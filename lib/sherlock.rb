#!/usr/bin/env ruby -wKU

# TODO: Output-Methoden für File- und Line-Collections, Tabellen, success & failure inkl. optionaler Colorierung.

%w(collection core_ext latex).each do |_module|
  require File.join(File.dirname(__FILE__), _module)
end

module Sherlock
  module VERSION #:nodoc:
    MAJOR = 0
    MINOR = 1
    BUILD = 1

    STRING = [MAJOR, MINOR, BUILD].join('.').freeze
  end
  
  module InstanceMethods
    def collect_files_matching(*args)
      Sherlock::Collection::Files.new(*args)
    end
    alias investigate collect_files_matching
  end
  
  class << self
    def included(base)
      base.__send__(:include, InstanceMethods)
    end
    include InstanceMethods
    alias [] collect_files_matching
  end
end