#!/bin/bash

code_to_error_de()
{
  case $1 in
    1)
      echo "Der Datei wurde nicht gefunden:"
      ;;
    2)
      echo "Berechtigung zum Lesen der Datei verweigert:"
      ;;
  esac
}

code_to_error_en()
{
  case $1 in
    1)
      echo "File not found:"
      ;;
    2)
      echo "Permission to read the file denied:"
      ;;
  esac
}

print_error()
{
  if [[ "$LANG" == de_DE* ]]
  then
    echo "$(code_to_error_de $1) $2" >> debug.log
  else
    echo "$(code_to_error_en $1) $2" >> debug.log
  fi
}

print_error 1 "readme.txt"
