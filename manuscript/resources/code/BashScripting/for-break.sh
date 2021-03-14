#!/bin/bash

array=(Alice Bob Eve Mallory)
is_found="0"

for element in "${array[@]}"
do
  if [[ "$element" == "$1" ]]
  then
    is_found="1"
    break
  fi
done

if [[ "$is_found" -ne "0" ]]
then
  echo "The array contains the $1 element"
else
  echo "The array does not contain the $1 element"
fi
