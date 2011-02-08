#!/usr/bin/env ruby -wKU

require 'fileutils'

def rebuild_test_data_dir!
  FileUtils.rm_rf(test_data_dir)
  FileUtils.mkdir_p(test_data_dir)
  FileUtils.cp_r(original_test_data_dir, tmp_dir)
end

def original_test_data_dir
  File.join(File.dirname(__FILE__), '..', 'test_data')
end

def test_data_dir
  File.join(tmp_dir, 'test_data')
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