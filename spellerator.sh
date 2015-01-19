#!/bin/bash
# Spell check a project 

dir=$1

for file in $(find $dir -path $dir/.git -prune -o -type f -exec file -F "" {} + | grep ASCII | awk '{ print $1 }') 
  do
    hunspell $file
  done	


