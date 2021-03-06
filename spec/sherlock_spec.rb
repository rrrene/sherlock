require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe Sherlock do
  describe "#investigate" do
    it "creates a collection of all text files" do
      files = Sherlock.investigate('**/*.txt')
      files.should_not be_empty
    end
    
    it "creates an empty collection" do
      files = Sherlock.investigate('**/not-there')
      files.should be_empty
    end
  end
end