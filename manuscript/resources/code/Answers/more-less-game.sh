#!/bin/bash

number=$((RANDOM % 100 + 1))

for i in {1..7}
do
  echo "Enter the number:"

  read input

  if (( input < number))
  then
    echo "The number $input is less"
  elif (( number < input))
  then
    echo "The number $input is greater"
  else
    echo "You guessed the number"
    exit 0
  fi
done

echo "You didn't guess the number"
