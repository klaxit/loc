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
    loc1 = described_class.new(50.0359, -0.054253)
    loc2 = described_class.new(58.3838, -0.030412)
    expect(loc1.distance_to(loc2)).to eq 928245.4072998187
  end

  it "should give bearing from object to another" do
    loc1 = described_class.new(48.89364, 2.33739)
    loc2 = described_class.new(48.91071, 2.00597)
    expect(loc1.bearing_to(loc2)).to eq 272.9484505245889
  end

  it "should give latitude degrees per kilometer" do
    loc = described_class.new(48.93021, 2.34657)
    expect(loc.lat_degrees_per_km.round(7)).to eq 0.0089932
  end

  it "should give longitude degrees per kilometer" do
    loc = described_class.new(48.93021, 2.34657)
    expect(loc.lng_degrees_per_km.round(7)).to eq 0.0136889
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
end
