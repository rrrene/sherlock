#!/usr/bin/env ruby -wKU

# TODO: Vielleicht Möglichkeit 'gsub' auf ganze FileCollection zu machen (wird einfach auf File.read(f) angewendet).
# TODO: Möglichkeit MatchedLine Objekte zu ändern und in Datei zurückzuspeichern.
# TODO: 'rewrite' auf LineCollection, die genau das tut.
#       -> muss natürlich rückwärts die LineCollection durchlaufen, damit sich Zeilennummern nicht ändern...
#   investigate(/literatur/).collect(/\\quelle\{(.+\(\d{4}\))\}[\s\\]+/).rewrite { |line| "%" + line }
# TODO: Output-Methoden für File- und Line-Collections, Tabellen, success & failure inkl. optionaler Colorierung.
# TODO: vielleicht LaTex shortcuts à la tex_files.inputs(:only => 'generated/schema')

# DONE: Möglichkeit 'gsub' auf ganze LineCollection zu machen (wird nicht direkt gespeichert, sondern kann weiter verwendet werden).
# DONE: Methoden wie 'first', '+', '-' etc. für LineCollection adaptieren.


%w(collection core_ext latex).each do |_module|
  require File.join(File.dirname(__FILE__), _module)
end

module Detective
  module InstanceMethods
    def collect_files_matching(*args)
      Detective::Collection::Files.new(*args)
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