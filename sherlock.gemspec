$:.unshift('lib')
require 'sherlock'

Gem::Specification.new do |s|
  s.author = "René Föhring"
  s.email = 'rf@bamaru.de'
  s.homepage = "http://bamaru.com"

  s.name = 'sherlock'
  s.version = Sherlock::VERSION::STRING
  s.platform = Gem::Platform::RUBY
  s.summary = "A library for filtering lists of files and performing actions on their content."
  s.description = "A library for filtering lists of files and performing actions on their content."

  s.files = Dir[ 'lib/**/*', 'spec/**/*']
  s.has_rdoc = false
  s.require_path = 'lib'
  s.requirements << 'none'

  s.add_dependency('rspec', '~> 1.3.0')
end