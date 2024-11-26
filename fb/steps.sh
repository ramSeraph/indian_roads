#!/bin/sh

mkdir data

cd data
wget https://mapwith.ai/country_exports/IN_PK_mapwithai_road_data.gpkg.tar.gz
tar -xzf IN_PK_mapwithai_road_data.gpkg.tar.gz
ogr2ogr -f GeoJSONSeq IN_PK_mapwithai_road_data.geojsonl IN_PK_mapwithai_road_data.gpkg
wget https://mapwith.ai/country_exports/CN_mapwithai_road_data.gpkg.tar.gz
tar -xzf CN_mapwithai_road_data.gpkg.tar.gz
ogr2ogr -f GeoJSONSeq CN_mapwithai_road_data.geojsonl CN_mapwithai_road_data.gpkg
cd -

python clip_roads.py data/IN_PK_mapwithai_road_data.geojsonl
python clip_roads.py data/CN_mapwithai_road_data.geojsonl
