#!/bin/sh
#
# Script to remove anchors to page titles.
#
# The main motivation is that Paradox doesn't verify them so they add
# extra noise to the markdown.

DIR="${1:-docs/src/main/paradox}"

anchors=$(find "$DIR" -name "*.md" | xargs -n 1 head -1 | sed -n 's#<a id="\(.*\)"></a>#\1#p')
files=$(find "$DIR" -name "*.md")
# Remove fragments from links
for id in $anchors; do sed -i "s/#$id[)]/)/" $files; done
# Remove top-level page anchors
for id in $anchors; do sed -i "/^<a.id=.$id.><.a>$/d" $files; done
