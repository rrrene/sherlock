$:.unshift('lib')
require 'sherlock/version'

Gem::Specification.new do |s|
  s.author = "René Föhring"
  s.email = 'rf@bamaru.de'
  s.homepage = "http://github.com/rrrene/sherlock"

  s.name = 'sherlock'
  s.version = Sherlock::VERSION::STRING.dup
  s.platform = Gem::Platform::RUBY
  s.summary = "A library for filtering lists of files and performing actions on their content."
  s.description = "A library for filtering lists of files and performing actions on their content."

  s.files = Dir[ 'lib/**/*', 'spec/**/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_development_dependency 'rspec'
end