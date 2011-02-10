#!/usr/bin/env ruby -wKU

require File.join(File.dirname(__FILE__), 'lib', 'sherlock')

include Sherlock
include Sherlock::LaTex

require 'irb'
require 'irb/completion'
IRB.start