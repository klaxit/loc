module Loc
  class Location

    attr_reader :lat, :lng

    def initialize(lat, lng)
      raise(TypeError, "lat should be a Numeric.") unless lat.is_a?(Numeric)
      raise(TypeError, "lng should be a Numeric.") unless lng.is_a?(Numeric)
      @lat = lat
      @lng = lng
    end

    class << self
      def from_array(a)
        new(a[0], a[1])
      end

      def [](*args)
        from_array(args)
      end

      alias from_a from_array
    end

    # Calculate the distance in meters betwen the object
    # and another location using the 'Haversine' formula.
    # Params :
    # +other+:: Location
    def distance_to(other)
      dlat = to_radians(other.lat - lat)
      dlon = to_radians(other.lng - lng)
      a = Math.sin(dlat / 2) * Math.sin(dlat / 2) +
          Math.cos(to_radians(lat)) * Math.cos(to_radians(other.lat)) *
          Math.sin(dlon / 2) * Math.sin(dlon / 2)
      c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a))
      6371 * c * 1000
    end

    # Give the bearing from the object to the other.
    # Params :
    # +other+:: Location
    def bearing_to(other)
      dlat = to_radians(other.lat - lat)
      dlng = to_radians(other.lng - lng)
      bearing = Math.atan2(dlat, dlng)
      (90 - to_degrees(bearing) + 360) % 360
    end

    # Give the number of latitude degrees
    # for a kilometer distance at location
    def lat_degrees_per_km
      1 / 111.195
    end

    # Calculate the number of longitude degrees
    # for kilometer distance at location
    def lng_degrees_per_km
      1 / (distance_to(Location[lat, lng + 1]) / 1000)
    end

    def ==(other)
      return true if other.equal?(self)
      return false unless other.instance_of?(self.class)
      lat == other.lat && lng == other.lng
    end

    def [](*args)
      to_array[*args]
    end

    def to_array
      [lat, lng]
    end

    def to_hash
      { lat: lat, lng: lng }
    end

    def to_s
      "#{lat},#{lng}"
    end

    def inspect
      "<#{self.class} #{{ lat: lat, lng: lng }}>"
    end

    alias to_a to_array
    alias to_h to_hash

    private

    def to_radians(deg)
      deg * Math::PI / 180
    end

    def to_degrees(rad)
      rad * 180 / Math::PI
    end
  end
end
