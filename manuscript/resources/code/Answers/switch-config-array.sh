#!/bin/bash

option="$1"

declare -A files=(
  ["h"]="~/.bashrc-home"
  ["w"]="~/.bashrc-work")

if [[ -z "$option" || ! -v files["$option"] ]]
then
  echo "Invalid option"
  exit 1
fi

rm ~/.bashrc

ln -s "${files["$option"]}" ~/.bashrc
