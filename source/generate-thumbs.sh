#!/usr/bin/env bash

images=`find images/*.png`

for im in $images; do
  convert -resize 25% $im thumb/${im:7:${#im}}
done



