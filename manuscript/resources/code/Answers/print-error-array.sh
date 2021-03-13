#!/bin/bash

print_error()
{
  declare -A messages

  messages["de_DE",1]="Der Datei wurde nicht gefunden:"
  messages["de_DE",2]="Berechtigung zum Lesen der Datei verweigert:"

  messages["en_US",1]="File not found:"
  messages["en_US",2]="Permission to read the file denied:"

  echo "${messages[$LANGUAGE,$1]} $2" >> debug.log
}

print_error 1 "readme.txt"
