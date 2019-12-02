#!/bin/bash

input='./day01.input'

summary=0
while IFS='' read -r line || [[ -n "$line" ]]; do
  (( summary += line / 3 - 2 ))
done < $input

echo Answer: $summary