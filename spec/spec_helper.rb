#!/usr/bin/env ruby -wKU

$:.unshift(File.join(File.dirname(__FILE__), "..", "lib"))

require 'detective'

require 'rubygems'
require 'rspec'

require 'fileutils'

def rebuild_test_data_dir!
  FileUtils.rm_rf(test_data_dir)
  FileUtils.mkdir_p(test_data_dir)
  FileUtils.cp_r(original_test_data_dir, tmp_dir)
end

def original_test_data_dir
  File.join(File.dirname(__FILE__), 'fixtures')
end

def test_data_dir
  File.join(tmp_dir, 'fixtures')
end

def tmp_dir
  File.join(File.dirname(__FILE__), '..', 'tmp')
end

RSpec.configure do |config|
  config.before(:each) {
    rebuild_test_data_dir!
    Dir.chdir(test_data_dir)
  }
end