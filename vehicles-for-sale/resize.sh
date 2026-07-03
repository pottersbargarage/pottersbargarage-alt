#!/bin/bash

max_width=800

for f in *.png; do
  w=$(sips -g pixelWidth "$f" | awk '/pixelWidth/{print $2}');
  [ "$w" -gt ${max_width} ] && sips --resampleWidth ${max_width} "$f";
done
