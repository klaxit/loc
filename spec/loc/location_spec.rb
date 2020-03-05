require 'spec_helper'

describe Loc::Location do
  it "can be created from an Array" do
    location = described_class.from_array([1, 2])
    expect(location.lat).to eq 1
    expect(location.lng).to eq 2
  end

  it "can be created from array with [] syntax" do
    location = described_class[1, 2]
    expect(location.lat).to eq 1
    expect(location.lng).to eq 2
  end

  it "can be accessed with [] syntax" do
    location = described_class[1, 2]
    expect(location[0]).to eq 1
    expect(location[1]).to eq 2
  end

  it "should give the distance in meters using \"Haversine\" formula" do
    loc1 = described_class.new(50, 2)
    loc2 = described_class.new(49, 3)
    expect(loc1.distance_to(loc2)).to eq 132584.3578090791
  end

  it "should give bearing from object to another" do
    loc1 = described_class.new(50, 2)
    loc2 = described_class.new(51, 2)
    expect(loc1.bearing_to(loc2)).to eq 0
    loc2 = described_class.new(51, 3)
    expect(loc1.bearing_to(loc2)).to eq 45.0
    loc2 = described_class.new(50, 3)
    expect(loc1.bearing_to(loc2)).to eq 90.0
    loc2 = described_class.new(49, 2)
    expect(loc1.bearing_to(loc2)).to eq 180.0
    loc2 = described_class.new(50, 1)
    expect(loc1.bearing_to(loc2)).to eq 270.0
  end

  it "should give latitude degrees per kilometer" do
    loc = described_class.new(50, 2)
    expect(loc.lat_degrees_per_km.round(7)).to eq 0.0089932
  end

  it "should give longitude degrees per kilometer" do
    loc = described_class.new(50, 2)
    expect(loc.lng_degrees_per_km.round(7)).to eq 0.0139911
  end

  it "can understand equality" do
    loc1 = described_class.new(1, 2)
    loc2 = described_class.new(1, 2)
    expect(loc1).to eq(loc2)
  end

  it "can be converted to Hash" do
    loc = described_class.new(1, 2)
    expect(loc.to_hash).to eq(lat: 1, lng: 2)
  end

  it "can be converted to an Array" do
    loc = described_class.new(1, 2)
    expect(loc.to_a).to eq([1, 2])
  end

  it "can't be created from strings" do
    expect { described_class.new("1", "2") }.to raise_error TypeError
  end
end
