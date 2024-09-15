#!/bin/bash

set -e

rm -f planet/planet-latest.osm.pbf planet/planet-latest.osm.pbf.md5
(cd planet && wget http://ftp5.gwdg.de/pub/misc/openstreetmap/planet.openstreetmap.org/pbf/planet-latest.osm{.pbf,.pbf.md5} && md5sum -c *.md5)

# Mapbox GL import
(cd mapbox && ./run_planetiler.sh)
rm -rf mapbox/tiles
./mapbox_planetiler_split.py mapbox/planetiler/output.mbtiles hierarchy mapbox/tiles
mapbox/make_packs.py
rm -rf distribution/mapboxgl/packages
mkdir -p distribution/mapboxgl/packages
cp mapbox/packages/*.bz2 distribution/mapboxgl/packages/

echo Mapbox GL glyphs imported and already packed
#./pack.sh distribution/mapboxgl/glyphs 1

# Valhalla import
valhalla/import_planet_install_dist.sh planet/planet-latest.osm.pbf
valhalla/make_packs.py
rm -rf distribution/valhalla/packages
mkdir -p distribution/valhalla/packages
cp valhalla/packages/*tar.bz2 distribution/valhalla/packages/

# # Splitting is not needed anymore as we don't import anything from
# # splitted PBF
# rm -rf splitted
# ./prepare_splitter.py
# nice -n 19 make -f Makefile.splitter

rm -rf distribution/geocoder-nlp
./prepare_countries.py
nice -n 19 make -f Makefile.import -j16

./prepare_distribution.py

./check_import.py

#./uploader.sh

