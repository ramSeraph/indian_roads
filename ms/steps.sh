#!/bin/sh

mkdir data

wget -O data/india-composite.geojson https://raw.githubusercontent.com/datameet/maps/master/Country/india-composite.geojson

wget -O data/roads.zip https://usaminedroads.blob.core.windows.net/road-detections/AsiaSouth-Full.zip

cd data
unzip roads.zip
cd -

pip install shapely
python clip_roads.py

tippecanoe -P -zg  -o data/ms_roads_india.mbtiles --drop-densest-as-needed --extend-zooms-if-still-dropping -l ms_roads_india -n ms_roads_india -A '<a href="https://github.com/microsoft/RoadDetections" target="_blank" rel="noopener noreferrer">MS Roads</a> - <a href="https://opendatacommons.org/licenses/odbl/" target="_blank" rel="noopener noreferrer">ODbl</a>' data/ms_roads_india.geojsonl

pmtiles convert data/ms_roads_india.mbtiles data/ms_roads_india.pmtiles

