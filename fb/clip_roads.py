import sys
import csv
import json
from pathlib import Path

from shapely.geometry import shape
from shapely.prepared import prep

fname = sys.argv[1]


def load_india_shape():
    data = json.loads(Path('data/india-composite.geojson').read_text())
    geom = data['features'][0]['geometry']
    return prep(shape(geom))


if __name__ == '__main__':
    india_shape = load_india_shape()

    with open(f'data/fb_ml_roads_india.geojsonl', 'a') as outf:
        #with open(f'data/IN_PK_mapwithai_road_data.geojsonl', 'r') as f:
        with open(fname, 'r') as f:
            for line in f:
                feat = json.loads(line)
                geom = feat['geometry']
                s = shape(geom)
                if not india_shape.intersects(s):
                    continue
                del feat['properties']['wkt']
                outf.write(json.dumps(feat))
                outf.write('\n')



