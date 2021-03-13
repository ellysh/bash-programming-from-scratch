#!/bin/bash

code_to_error()
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
  echo "$(code_to_error $1) $2" >> debug.log
}

print_error 1 "readme.txt"
