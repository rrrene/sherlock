require 'spec_helper'

describe Detective do
  describe "#investigate" do
    it "creates a collection of all text files" do
      files = Detective.investigate('**/*.txt')
      files.should_not be_empty
    end
    
    it "creates an empty collection" do
      files = Detective.investigate('**/not-there')
      files.should be_empty
    end
  end
end