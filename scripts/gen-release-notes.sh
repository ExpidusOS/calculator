#!/usr/bin/env sh

ref="$1"
format="$2"

git log "$ref" --pretty="$format" | grep -E "(fix|feat)" | grep -E -v '\((ci|android|linux|macos|ios|web)\)' | grep -E -v "typo" | uniq
