require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Detective::Collection::Files do
  def text_files(opts = {})
    Detective::Collection::Files.new('**/*.txt', opts)
  end
  
  def some_line
    lines = text_files.collect('Zeile')
    lines[0]
  end
  
  describe "#initialize" do
    it "should be an unchanged line" do
      some_line.changed?.should == false
    end
  end
  
  describe "#gsub" do
    it "modifies a line" do
      line = some_line
      new_line = line.gsub(/^(.*)/, 'X \1')
      new_line[0..0].should == 'X'
      new_line.changed?.should == true
      new_line[0..0].should != 'X'
      line.changed?.should == false
    end
  end
  
end