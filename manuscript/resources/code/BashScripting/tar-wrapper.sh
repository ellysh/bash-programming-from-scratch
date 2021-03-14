#!/bin/bash

utility="$1"

case "$utility" in
  "-b"|"--bsdtar")
    bsdtar "${@:2}"
    ;;

  "-t"|"--tar")
    tar "${@:2}"
    ;;

  *)
    echo "Invalid option"
    exit 1
    ;;
esac
