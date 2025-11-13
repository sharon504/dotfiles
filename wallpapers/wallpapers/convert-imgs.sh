#!/bin/sh

for img in *.png; do
  [ -e "$img" ] || continue  # skip if no .png files exist
  base="${img%.png}"
  magick "$img" "$base.jpg"
done

