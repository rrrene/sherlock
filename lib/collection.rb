#!/usr/bin/env ruby -wKU

sub_dir = File.basename(__FILE__, '.rb')
all_files = Dir[File.join(File.dirname(__FILE__), sub_dir, '*.rb')]
all_files.sort.map { |f| File.basename(f, '.rb') }.each do |_module|
  require File.join(File.dirname(__FILE__), sub_dir, _module)
end

