#!/usr/bin/env ruby -wKU

require File.join(File.dirname(__FILE__), 'lib', 'detective')

include Detective
include Detective::LaTex

require 'irb'
require 'irb/completion'
IRB.start