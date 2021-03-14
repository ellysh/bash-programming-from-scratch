#!/bin/bash

array=(Alice Bob Eve Mallory)

for element in "${array[@]}"
do
  if [[ "$element" == "$1" ]]
  then
    echo "The array contains the $1 element"
    exit 0
  fi
done

echo "The array does not contain the $1 element"
