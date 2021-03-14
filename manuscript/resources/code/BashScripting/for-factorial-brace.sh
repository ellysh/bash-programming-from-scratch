#!/bin/bash

result=1

for i in {1..5}
do
  ((result *= $i))
done

echo "The factorial of 5 is $result"
