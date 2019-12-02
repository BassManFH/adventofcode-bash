#!/bin/bash

input='./day01.input'

calculate_fuel() {
  mass=$1
  (( fuel = mass / 3 - 2 ))
  if [[ $fuel -lt 0 ]]; then
    fuel=0
  else
    more_mass=$(calculate_fuel $fuel)
    (( fuel += more_mass ))
  fi
  echo $fuel
}

summary=0
while IFS='' read -r line || [[ -n "$line" ]]; do
  fuel=$(calculate_fuel $line)
  (( summary += fuel ))
done < $input

echo Answer: $summary