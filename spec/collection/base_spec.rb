require 'spec_helper'
require 'detective'

describe Detective::Collection::Base do
  describe "#initialize" do
    it "creates an empty collection" do
      collection = Detective::Collection::Base.new
      collection.should be_empty
    end
  end
  
  # TODO: testen, dass filter(), und first() und containing und so alle String, Regexp sowie [String/Regexp] nehmen
  
end