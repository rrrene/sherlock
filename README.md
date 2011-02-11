# Sherlock

## Description

Sherlock is a ruby library that allows you to first filter lists of files based on their name and content and then investigate those files by collecting lines that match a given pattern.
    
    # Collect all todos from a project
    Sherlock['**/*'].collect(/TODO:(.+)/).matches
    
    # Select all latex files which don't include other files
    Sherlock['**/*.tex'].not_containing(['\include', '\input'])
    
## Installation

  gem install sherlock
  
## Usage

The Sherlock brackets accessor takes a glob as first argument, just like Dir:
  
    Dir['**/*.tex']
    Sherlock['**/*.tex']

### List filtering

To filter this set of files further, use the options parameter:
  
    Sherlock['**/*.tex', {:only => /^\d+/, :except => /table_of_contents/})
    
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

### Collecting lines of text

Like the namesake of this module, we often want to dig deeper and investigate further:
  
    Sherlock['**/*.tex']
    # => Sherlock::Collection::Files
    
    Sherlock['**/*.tex'].collect(/% TODO:(.+)/) 
    # => Sherlock::Collection::Lines
    
This returns a collection of lines that matched the given argument. 

To get the matched part of the line, you can use the matches method:
  
    Sherlock['**/*.tex'].collect(/% TODO:(.+)/).matches
    # => [['improve headline'], ['write conclusion'], ['get an A']]
    
### Modifying lines of text

Finally, you want to be able to not only use your findings, but change the content of the collected lines.

You can using the gsub and save! method:
    
    Sherlock['**/*.tex'].collect(/% URGENT:/).gsub('URGENT', 'TODO').save!
    
gsub and save! work both on collections of lines as well as individual line objects!


## License

Released under the MIT License. See the LICENSE file for further details.