require 'spec_helper'

describe Loc::LocationCollection do

  it "can be created from an Array" do
    collection = described_class.from_array([[1, 2], [3, 4]])
    expect(collection.locations[0]).to eq Loc::Location[1, 2]
    expect(collection.locations[1]).to eq Loc::Location[3, 4]
  end

  it "can be created from array with [] syntax" do
    collection = described_class[[1, 2], [3, 4]]
    expect(collection.locations[0]).to eq Loc::Location[1, 2]
    expect(collection.locations[1]).to eq Loc::Location[3, 4]
  end

  it "should understand [] syntax" do
    collection = described_class.new([[1, 2], [3, 4]])
    expect(collection[0]).to eq Loc::Location[1, 2]
    expect(collection[1]).to eq Loc::Location[3, 4]
  end

  it "should give geodesic distance between ordered locations" do
    locs = described_class.new([[1, 2], [2, 3], [3, 4]])
    expect(locs.distance).to eq 314402.9838527136
  end

  it "should understand equality" do
    collection_1 = described_class.new([[1, 2], [3, 4]])
    collection_2 = described_class.new([[1, 2], [3, 4]])
    collection_3 = described_class.new([[5, 6], [7, 8]])
    expect(collection_1).to eql collection_2
    expect(collection_1).to eq collection_2
    expect(collection_1).to_not eql collection_3
    expect(collection_1).to_not eq collection_3
  end

  it "should be enumerable" do
    expect(subject).to be_a Enumerable
    expect(subject).to respond_to :each_cons
  end

  describe "#size" do
    it "should give location collection size" do
      collection = described_class.new(
        [Loc::Location[1, 2], Loc::Location[3, 4]]
      )
      expect(collection.size).to eq 2
    end
  end

  describe "#each" do
    let(:array) { [Loc::Location[1, 2], Loc::Location[3, 4]] }
    let(:collection) { described_class.new(array) }
    it "should return enum" do
      expect(collection.each).to contain_exactly *array
    end
    it "should execute block for all locations" do
      each_location = []
      collection.each { |location| each_location << location }
      expect(each_location).to contain_exactly *array
    end
  end

  describe "#map" do
    it "should map each location" do
      collection = described_class.new([[1,2],[3,4]])
      expect(
        collection.map{|l| l.class.name }
      ).to eq(["Loc::Location", "Loc::Location"])
    end
  end

  describe "#shift" do
    let(:array) { [Loc::Location[1, 2], Loc::Location[3, 4]] }
    let(:collection) { described_class.new(array) }
    it "should give first element" do
      expect(collection.shift).to eq Loc::Location[1, 2]
    end
    it "should remove first element" do
      collection.shift
      expect(collection.locations).to eq [Loc::Location[3, 4]]
    end
  end

  describe "#pop" do
    let(:array) { [Loc::Location[1, 2], Loc::Location[3, 4]] }
    let(:collection) { described_class.new(array) }
    it "should give last element" do
      expect(collection.pop).to eq Loc::Location[3, 4]
    end
    it "should remove last element" do
      collection.pop
      expect(collection.locations).to eq [Loc::Location[1, 2]]
    end
  end

  describe "#hash" do
    it "should give hash based on collection" do
      collection_1 = described_class.new([[1, 2], [3, 4]])
      collection_2 = described_class.new([[1, 2], [3, 4]])
      collection_3 = described_class.new([[5, 6], [7, 8]])
      expect(collection_1.hash).to eq collection_2.hash
      expect(collection_1.hash).to_not eq collection_3.hash
    end
  end

  describe "#to_array" do
    it "should give an array of locations as array" do
      array = [[1,2],[3,4]]
      collection = described_class.new(array)
      expect(collection.to_array).to eq array
    end
  end
end
