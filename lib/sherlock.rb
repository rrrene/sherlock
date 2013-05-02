#!/usr/bin/env ruby -wKU

# TODO: Output-Methoden für File- und Line-Collections, Tabellen, success & failure inkl. optionaler Colorierung.

%w(collection core_ext latex version).each do |_module|
  require File.join(File.dirname(__FILE__), "sherlock", _module)
end

module Sherlock
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