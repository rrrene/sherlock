require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Detective::Collection::Base do
  def new_collection
    Detective::Collection::Base.new(%w(eins zwei drei vier fünf))
  end
  
  describe "#initialize" do
    it "creates an empty collection" do
      empty_collection = Detective::Collection::Base.new
      empty_collection.should be_empty
    end
    it "creates a full collection" do
      collection = new_collection
      collection.should_not be_empty
    end
  end
  
  describe "#first" do
    it "should give the first matching element for strings" do
      item = new_collection.first('ei')
      item.should == 'eins'
    end
  end
  
  # TODO: testen, dass filter(), und first() und containing und so alle String, Regexp sowie [String/Regexp] nehmen
  
end