import csv
import json
from pathlib import Path

from shapely.geometry import shape
from shapely.prepared import prep



def load_india_shape():
    data = json.loads(Path('data/india-composite.geojson').read_text())
    geom = data['features'][0]['geometry']
    return prep(shape(geom))


if __name__ == '__main__':
    india_shape = load_india_shape()

    with open(f'data/ms_roads_india.geojsonl', 'w') as outf:
        with open(f'data/AsiaSouth-Full.tsv', 'r') as f:
            reader = csv.reader(f, delimiter='\t')
            for r in reader:
                feat = json.loads(r[1])
                geom = feat['geometry']
                s = shape(geom)
                if not india_shape.intersects(s):
                    continue
                outf.write(r[1])
                outf.write('\n')



