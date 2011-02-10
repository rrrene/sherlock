require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Sherlock::Collection::Base do
  def new_collection(arr = nil, opts = {})
    arr ||= %w(eins zwei drei vier fünf)
    Sherlock::Collection::Base.new(arr, opts)
  end
  
  def filter_arguments
    [
      [['ei']],
      [[/ei/]],
      [['sieben', 'sechs', 'fünf', 'vier']],
      [[/ei/, 'fünf'], {:only => /ei$/, :except => 'zwei'}],
      [{:only => /ei$/, :except => 'zwei'}],
    ]
  end
  
  describe "#initialize" do
    it "creates an empty collection without arguments" do
      empty_collection = Sherlock::Collection::Base.new
      empty_collection.should be_empty
    end
    it "creates a full collection for a given array" do
      collection = new_collection([:foo, :bar])
      collection.should_not be_empty
    end
    it "creates a full collection for a given collection" do
      collection = new_collection(new_collection)
      collection.should_not be_empty
    end
  end
  
  describe "#first" do
    it "should give a collection with the first matching element for a string" do
      collection = new_collection.first('ei')
      collection.should == new_collection(%w(eins))
    end
    it "should give a collection with the first matching element for a regexp" do
      collection = new_collection.first(/ei/)
      collection.should == new_collection(%w(eins))
    end
    it "should give a collection with the first matching element for an array of strings" do
      collection = new_collection.first(%w(sieben sechs fünf))
      collection.should == new_collection(%w(fünf))
    end
    it "should give a collection with the first matching element for an array of regexps" do
      collection = new_collection.first([/sieben/, /sechs/, /fünf/])
      collection.should == new_collection(%w(fünf))
    end
    it "should give a collection with the first matching element for an array of strings and regexps" do
      collection = new_collection.first([/sieben/, /sechs/, 'fünf'])
      collection.should == new_collection(%w(fünf))
    end
  end
  
  describe "#filter" do
    # without real arguments
    it "should give the same collection without arguments" do
      collection = new_collection.filter
      collection.should == new_collection
    end
    it "should give the same collection with empty arguments" do
      collection = new_collection.filter([], {})
      collection.should == new_collection
    end
    
    # without options
    it "should give a collection with the matching elements for a string" do
      collection = new_collection.filter('ei')
      collection.should == new_collection(%w(eins zwei drei))
    end
    it "should give a collection with the matching elements for a regexp" do
      collection = new_collection.filter(/ei/)
      collection.should == new_collection(%w(eins zwei drei))
    end
    it "should give a collection with the matching elements for an array of strings" do
      collection = new_collection.filter(%w(sieben sechs fünf vier))
      collection.should == new_collection(%w(vier fünf))
    end
    it "should give a collection with the matching elements for an array of regexps" do
      collection = new_collection.filter([/ei/, /sechs/, /fünf/])
      collection.should == new_collection(%w(eins zwei drei fünf))
    end
    it "should give a collection with the matching elements for an array of strings and regexps" do
      collection = new_collection.filter([/ei/, 'fünf'])
      collection.should == new_collection(%w(eins zwei drei fünf))
    end
    
    # with options
    it "should accept options as only argument" do
      collection = new_collection.filter(:except => 'zwei')
      collection.should == new_collection(%w(eins drei vier fünf))
    end
    it "should accept options as only argument (chained)" do
      collection = new_collection.filter([/ei/, 'fünf']).filter(:except => 'zwei')
      collection.should == new_collection(%w(eins drei fünf))
    end
    it "should filter results with :except option" do
      collection = new_collection.filter([/ei/, 'fünf'], :except => 'zwei')
      collection.should == new_collection(%w(eins drei fünf))
    end
    it "should filter results with :only option" do
      collection = new_collection.filter([/ei/, 'fünf'], :only => /ei$/)
      collection.should == new_collection(%w(zwei drei))
    end
    it "should filter results with :only option first and :except option afterwards" do
      collection = new_collection.filter([/ei/, 'fünf'], :only => /ei$/, :except => 'zwei')
      collection.should == new_collection(%w(drei))
    end
  end
  
  describe "#[]" do
    it "should be a shortcut for 'filter'" do
      filter_arguments.each do |args|
        new_collection[*args].should == new_collection.filter(*args)
      end
    end
  end
  
  describe "#+" do
    it "should combine two collections" do
      collection1 = new_collection(nil, :only => 'eins')
      collection2 = new_collection(nil, :only => 'zwei')
      result = collection1 + collection2
      result.should == new_collection(%w(eins zwei))
    end
  end
  
  describe "#-" do
    it "should reduce two collections" do
      collection1 = new_collection(nil, :only => /ei/)
      collection2 = new_collection(nil, :only => 'zwei')
      result = collection1 - collection2
      result.should == new_collection(%w(eins drei))
    end
  end
  
  # TODO: tests für #& und #| schreiben
  # TODO: testen, dass filter(), und first() und containing und so alle String, Regexp sowie [String/Regexp] nehmen
  
end