# Sherlock

## Description

Sherlock provides an easy way to filter collections of files and report/modify/save specific lines using ruby.

## Installation

  $ gem install sherlock
  
## Usage

The Sherlock brackets accessor takes a glob as first argument, just like Dir:
    
    # Select all tex files
    Dir['**/*.tex']
    Sherlock['**/*.tex']

And you can filter this collection, just like with Dir:
    
    # Select all tex files beginning with 'chapter' except chapter 0
    Dir['**/*.tex'].select { |f| f =~ /chapter_/ }.reject { |f| f == 'chapter_0' }
    Sherlock['**/*.tex', :only => /chapter_/, :except => 'chapter_0']

But you can also easily filter file collections by their content and report/modify/save specific lines of text.
    
    # Select all ruby files, comment all lines using 'puts' (except those lines that are already commented) and save the changes.
    Sherlock['**/*.rb'].lines(/puts/).filter(:except => /^#/).gsub(/.+/) { |line| "# #{line}" }.save!

## Collecting files

To filter this set of files further, use the options parameter:
  
    Sherlock['**/*.tex', :only => /^\d+/, :except => /table_of_contents/)
    
or you can use the filter method:
  
    Sherlock['**/*.tex'].filter(:only => /^\d+/, :except => /table_of_contents/)
    
The fitler method also takes a String, Regexp or Array as parameter (which is then interpreted as :only option):
  
    app = Sherlock['app/**/*.rb']
    models = app.filter(/models/)
    views = app.filter(/views/)
    controllers = app.filter(/controllers/)

which is aliased as []:
  
    app = Sherlock['app/**/*.rb']
    models = app[/models/]
    views = app[/views/]
    controllers = app[/controllers/]

The containing and not_containing methods can be used to filter file collections based on their content:
  
    Sherlock['app/**/*.rb'].containing('TODO:')

## Collecting lines

Like the namesake of this module, we often want to dig deeper and investigate further:
  
    Sherlock['**/*.tex']
    # => Sherlock::Collection::Files
    
    Sherlock['**/*.tex'].lines(/% TODO:(.+)/) 
    # => Sherlock::Collection::Lines
    
This returns a collection of lines that matched the given argument. 

To get the matched part of the line, you can use the matches method:
  
    Sherlock['**/*.tex'].lines(/% TODO:(.+)/).matches
    # => [['improve headline'], ['write conclusion'], ['get an A']]
    
## Modifying lines

Finally, you want to be able to not only use your findings, but change the content of the collected lines.

You can using the gsub and save! method:
    
    Sherlock['**/*.tex'].lines(/% URGENT:/).gsub('URGENT', 'TODO').save!
    
gsub and save! work both on collections of lines as well as individual line objects!

## Filtering in general

All filtering methods, such as filter, first, containing and not_containing, accept the :only and :except options (or a single argument which is interpreted as :only option).

    files = Sherlock['**/*.rb']
    files.filter(:only => 'controllers') == files.filter('controllers')
    files.filter(/(models|controllers)/) == files.filter(%w{models controllers})

Values provided to these options can be a Regexp, a String or an Array of Regexps/Strings.



## License

Released under the MIT License. See the LICENSE file for further details.
