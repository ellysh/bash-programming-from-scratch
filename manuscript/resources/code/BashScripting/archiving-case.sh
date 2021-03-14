#!/bin/bash

operation="$1"

case "$operation" in
  "-a")
    bsdtar -c -f documents.tar ~/Documents
    ;;

  "-c")
    bsdtar -c -j -f documents.tar.bz2 ~/Documents
    ;;

  "-x")
    bsdtar -x -f documents.tar*
    ;;

  *)
    echo "Invalid option"
    exit 1
    ;;
esac
