require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Detective::Collection::Files do
  def text_files(opts = {})
    Detective::Collection::Files.new('**/*.txt', opts)
  end
  
  def numbered_lines
    text_files(:only => /lines/).collect(/^.*(\d+\.)(.+)/)
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
      count = lines.size
      new_lines = lines.filter(:except => /^\d\./)
      count.should be > new_lines.count
    end
  end
  
  describe "#gsub" do
    it "filters a collection of lines" do
      lines = numbered_lines
      new_lines = lines.gsub(/^(.*)(\d+)(\..+)/) { |match|
        nr = match.match(/^\d+/)[0].to_i
        'X' * nr + " #{match}"
      }
      #new_lines.save!
    end
  end
  
end