#!/bin/bash

operation="$1"

case "$operation" in
  "-a")
    find Documents -name "*.pdf" -type f -print0 | xargs -0 bsdtar -c -j -f documents.tar.bz2
    cp documents.tar.bz2 ~/backup
    ;;

  "-c")
    cp documents.tar.bz2 ~/backup
    ;;

  *)
    echo "Invalid option"
    exit 1
    ;;
esac
