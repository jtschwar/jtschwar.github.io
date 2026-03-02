#!/bin/bash
# Usage: ./make_webp.sh <input.png> [sizes...]
# Default sizes: 480 800 1400
# Example: ./make_webp.sh assets/img/icon.png
# Example: ./make_webp.sh images/portrait.jpg 480 800

set -e

if [ -z "$1" ]; then
  echo "Usage: $0 <input_image> [size1 size2 ...]"
  exit 1
fi

INPUT="$1"
BASENAME="${INPUT%.*}"
SIZES="${@:2}"
[ -z "$SIZES" ] && SIZES="480 800 1400"

for SIZE in $SIZES; do
  TMP="/tmp/_resize_${SIZE}.png"
  OUT="${BASENAME}-${SIZE}.webp"
  sips --resampleWidth "$SIZE" "$INPUT" --out "$TMP" > /dev/null
  /opt/local/bin/cwebp -q 90 "$TMP" -o "$OUT" 2>/dev/null
  rm "$TMP"
  echo "Created $OUT"
done
