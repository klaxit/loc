module Loc
  class LocationCollection
    include Enumerable
    attr_reader :locations

    def initialize(locations = [])
      @locations = locations.map { |o| to_location(o) }
    end

    class << self
      def from_array(a)
        new(a)
      end

      def [](*args)
        new(args)
      end

      alias from_a from_array
    end

    # Give the distance in meters between ordered
    # location points using the 'Haversine' formula
    def distance
      return nil unless @locations.size > 1
      locations.each_cons(2).reduce(0) do |acc, (loc1, loc2)|
        acc + loc1.distance_to(loc2)
      end
    end

    def size
      locations.size
    end

    def [](*args)
      locations[*args]
    end

    def each(&block)
      locations.each(&block)
    end

    def shift
      locations.shift
    end

    def pop
      locations.pop
    end

    def ==(other)
      to_a == other.to_a
    end

    def eql?(other)
      to_a.eql?(other.to_a)
    end

    def hash
      to_a.hash
    end

    def to_array
      locations.map(&:to_a)
    end

    def inspect
      "<#{self.class} #{{ locations: @locations }}>"
    end

    alias to_a to_array

    private

    def to_location(object)
      case object
      when Location
        object
      when Array
        Location.from_array(object)
      else
        raise "Unsupported type #{object.class.name} for locations"
      end
    end
  end
end
