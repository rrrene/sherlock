require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sherlock::Collection::Files do
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
    
    it "should accept a glob (String) as first argument" do
      Sherlock['**/*.txt'].should == Dir['**/*.txt']
    end
    
    it "should accept a Symbol as first argument" do
      files = Sherlock[:txt]
      files.should == Sherlock["**/*.txt"]
    end
    
    it "should accept a Regexp as first argument" do
      Sherlock[/\.txt$/].should == Sherlock['**/*.txt']
    end    
  end
  
  describe "#lines" do
    it "collects all lines beginning with a number and a dot." do
      lines = text_files(:only => /lines/).lines(/^\d+\./)
      lines.should_not be_empty
    end
    
    it "tries to collect all lines beginning with a number and a dot." do
      lines = text_files(:except => /lines/).lines(/^\d+\./)
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