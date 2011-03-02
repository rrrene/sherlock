require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sherlock::Collection::Files do
  def numbered_lines
    text_files(:only => /lines/).lines(/^.*(\d+\.)(.+)/)
  end
  
  describe "#initialize" do
    it "creates an collection of lines looking like numbered lists" do
      lines = numbered_lines
      lines.should_not be_empty
    end
  end
  
  describe "#filter" do
    it "filters a collection of lines" do
      lines = numbered_lines
      new_lines = lines.filter(:except => /^\d\./)
      lines.count.should be > new_lines.count
    end
  end
  
  describe "#gsub" do
    it "modifies a collection of lines" do
      lines = numbered_lines
      new_lines = lines.gsub(/^(.*)(\d+)(\..+)/) do |match|
        "X #{match}"
      end
      new_lines.each do |line|
        line.changed?.should == true
      end
    end
  end
  
end