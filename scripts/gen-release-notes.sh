#!/usr/bin/env sh

ref=$1
format=$2

git log $ref --pretty=$format | egrep "(fix|feat)" | egrep -v '\((ci|android|linux|macos|ios|web)\)' | egrep -v "typo" | uniq
