#!/bin/bash

result=1

for i in $(seq $1)
do
  ((result *= $i))
done

echo "The factorial of $1 is $result"
