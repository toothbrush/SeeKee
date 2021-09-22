#!/usr/bin/env bash
set -uex

original="appicon-64.png"

identify "${original}"

convert "${original}" -resize "16x16" "appicon-16.png"
convert "${original}" -resize "32x32" "appicon-32.png"
# got 64, skip
convert "${original}" -filter point -interpolate integer -resize "64x64" "appicon-64.png"
convert "${original}" -filter point -interpolate integer -resize "128x128" "appicon-128.png"
convert "${original}" -filter point -interpolate integer -resize "256x256" "appicon-256.png"
convert "${original}" -filter point -interpolate integer -resize "512x512" "appicon-512.png"
convert "${original}" -filter point -interpolate integer -resize "1024x1024" "appicon-1024.png"
