#!/usr/bin/env ruby -wKU

require File.join(File.dirname(__FILE__), 'lib', 'detective')


include Detective
include Detective::LaTex

require 'pp'

#pp Dir['**/*.tex']
#pp investigate('**/*.tex') == Dir['**/*.tex']
#pp investigate("**/*.tex", :only => /\d\d/)
#pp investigate("**/*.tex", :only => /\d\d/, :except => /(preambel|anhang)/)
#pp investigate("**/*.tex", :only => /\d\d/, :except => /(preambel|anhang)/).collect(/TODO:(.+)/)
pp investigate("**/*.tex", :only => /\d\d/, :except => /(preambel|anhang)/).containing(/TODO/).collect(/TODO:(.+)/).matches


#pp tex_files[/anhang/, {:except => /\d\d/}]
#pp tex_files[0]


#pp investigate("**/*.tex", :only => /\d\d/, :except => /(literatur|anhang)/).collect([/(.+)% COMMENTME/, /TODO:(.+)/]).map { |l| l.match_data }

#pp investigate(/literatur/).collect(/\\quelle\{(.+\(\d{4}\))\}[\s\\]+/).map { |line| line.match_data[1] }
#pp tex_files.macros(:image)
#pp tex_files.tagged(:good)
#pp tex_files.not_containing("diplomarbeit").first(/einzeln/)

#master_file = tex_files[/anhang/].first
#filtered_collection = tex_files.filter(:only => /^\d/) + master_file

#pp filtered_collection
#pp filtered_collection.class

#pp tex_files.inputs(:only => 'generated').first(/schema/)

todos = tex_files.filter(:only => /^\d/).collect("TODO:")

pp todos.filter(:only => '2010') + todos[/englisch/]

#pp tex_files(:except => /(diplomarbeit|literaturverzeichnis)/).collect(/\\quelle/).count
#pp tex_files(:except => /(diplomarbeit|literaturverzeichnis)/).collect(/\\kapitel/).count
