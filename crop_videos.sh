#!/bin/bash
# Crop and resize 9 robot manipulation videos.
# v2: Different crop sizes per type to equalize torso size + add visual variation.
# Output: 540x720 (3:4), H264, no audio.
#
# Variation strategy:
#   Real:   tighter crop (492x656), shifted right — more zoomed, table at 73.5%
#   Neural: full width  (540x720), full view   — wider shot,  table at 70.6%
#   Ours:   tightest     (456x608), slight shift — most zoomed, table at 72.0%
#
# Torso output widths: Real=307, Neural=299, Ours=280 (~evenly spaced)

set -e

INDIR="videos"
OUTDIR="videos/cropped"
mkdir -p "$OUTDIR"

process() {
  local input="$1" output="$2" cw="$3" ch="$4" cx="$5" cy="$6"
  echo "Processing $input -> $output (crop=${cw}:${ch}:${cx}:${cy})"
  ffmpeg -y -i "$input" \
    -vf "crop=${cw}:${ch}:${cx}:${cy},scale=540:720" \
    -c:v libx264 -preset medium -crf 18 -an \
    "$output"
}

# Real videos: crop=492:656:44:200 (tighter, shifted right, table ~73.5%)
for f in "$INDIR"/real_demo_*.mp4; do
  base=$(basename "$f")
  process "$f" "$OUTDIR/$base" 492 656 44 200
done

# Neural videos: crop=540:720:0:179 (full width, table ~70.6%)
for f in "$INDIR"/neural_demo_*.mp4; do
  base=$(basename "$f")
  process "$f" "$OUTDIR/$base" 540 720 0 179
done

# Ours videos: crop=456:608:8:331 (tightest, table ~72.0%)
for f in "$INDIR"/ours_demo_*.mp4; do
  base=$(basename "$f")
  process "$f" "$OUTDIR/$base" 456 608 8 331
done

echo "Done! Output in $OUTDIR/"
