#!/usr/bin/env bash

images=`find images/*.png`

rm -f `find images/*-thumb.png`

for im in $images; do
  convert -resize 25% $im ${im:0:${#im}-4}-thumb.png
done



