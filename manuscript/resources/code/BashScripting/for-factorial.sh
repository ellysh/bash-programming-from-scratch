#!/bin/bash

result=1

for (( i = 1; i <= $1; ++i ))
do
  ((result *= i))
done

echo "The factorial of $1 is $result"
