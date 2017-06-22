# Loc

[![Gem Version](https://badge.fury.io/rb/loc.svg)](https://badge.fury.io/rb/loc)
[![CircleCI](https://circleci.com/gh/wayzup/loc.svg?style=shield&circle-token=:circle-token)](https://circleci.com/gh/wayzup/loc)

Helps anyone play with locations !

## Install

```
gem install loc
```

or in Bundler:
```
gem "loc"
```

## Usage

### Location

```
require "loc"

loc1 = Loc::Location[49.1, 2]

loc1.lat_degrees_per_km
# 0.008993210126354604

loc1.lng_degrees_per_km
# 0.013735635666645289

loc2 = Loc::Location[50, 3]

loc1.geodesic_distance(loc2)
# 123364.76538823603

loc1.linear_bearing(loc2)
# 48.01278750418339
```

### LocationCollection

```
require "loc"

collection = Loc::LocationCollection[[1,2],[3,4]]

collection.path_geodesic_distance
# 314402

collection[0]
# <Loc::Location {:lat=>1, :lng=>2}>

collection.each { |l| puts l.to_a }
# <Loc::Location {:lat=>1, :lng=>2}>
# <Loc::Location {:lat=>3, :lng=>4}>

collection.map(&:to_a)
# [[1, 2], [3, 4]]
```

## License

Please see LICENSE
