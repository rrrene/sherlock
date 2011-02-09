require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Detective::Collection::Files do
  def text_files(opts = {})
    files = Detective::Collection::Files.new('**/*.txt', opts)
  end
  
  def filtered_by_initialize(filter = {:only => /lines/})
    text_files(filter)
  end
  
  describe "#initialize" do
    it "creates an collection of all text files" do
      files = text_files
      files.should_not be_empty
    end
    
    it "filters text files by name" do
      filtered_by_method = text_files.filter(:only => /lines/)
      filtered_by_initialize.should == filtered_by_method
    end
  end
  
  describe "#collect" do
    it "collects all lines beginning with a number and a dot." do
      lines = text_files(:only => /lines/).collect(/^\d+\./)
      lines.should_not be_empty
    end
    
    it "tries to collect all lines beginning with a number and a dot." do
      lines = text_files(:except => /lines/).collect(/^\d+\./)
      lines.should be_empty
    end
  end
  
  describe "#select_files_containing" do
    it "selects all text files containing numbered lists" do
      files = text_files.containing(/^.*\d+\./)
      files.should_not be_empty
      files.should == text_files(:only => 'lines.txt')
    end
  end

  describe "#select_files_not_containing" do
    it "selects all text files not containing numbered lists" do
      files = text_files.not_containing(/^.*\d+\./)
      files.should_not be_empty
      files.should == text_files(:except => 'lines.txt')
    end
  end
end