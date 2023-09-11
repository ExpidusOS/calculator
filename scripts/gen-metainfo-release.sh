#!/usr/bin/env sh

set -e

ref=$1

appstreamcli metainfo-to-news --format=yaml data/com.expidusos.calculator.metainfo.xml NEWS.orig

cat << EOF > NEWS.new
---
Version: $ref
Date: $(date +'%Y-%m-%d')
Description: |-
EOF

./scripts/gen-release-notes.sh "$ref" "  * %s" >> NEWS.new

cat NEWS.new NEWS.orig > NEWS
rm NEWS.orig NEWS.new

appstreamcli news-to-metainfo --format=yaml NEWS data/com.expidusos.calculator.metainfo.xml data/com.expidusos.calculator.metainfo.xml

rm NEWS
