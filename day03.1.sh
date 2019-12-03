#!/bin/bash

input='./day03.input'

wire_one=$(head -n 1 $input | tr ',' ' ')
wire_two=$(head -n 2 $input | tail -n 1 | tr ',' ' ')

# associative massive to use as a fake 2D array
declare -A trace

# function to create "map" in $trace array or check for crossing
calc_trace() {
  for (( i=0; i<$2; i++)); do
    if [[ $1 == 'U' ]]; then
      (( y++ ))
    elif [[ $1 == 'R' ]]; then
      (( x++ ))
    elif [[ $1 == 'D' ]]; then
      (( y-- ))
    else
      (( x-- ))
    fi
    if [[ $3 == 'cross' ]]; then
      if [[ ${trace[$x,$y]} -eq 1 ]]; then
        absx=${x#-}
        absy=${y#-}
        (( distance = absx + absy ))
        if [[ $distance -lt $min_distance || $min_distance -eq 0 ]]; then
          min_distance=$distance
        fi
      fi
    else
      trace[$x,$y]=1
    fi
  done
}

# create map from the first input line
x=0
y=0
for step in $wire_one; do
  direction=${step:0:1}
  distance=${step:1}
  calc_trace $direction $distance
done

# find crossings with a second line
x=0
y=0
min_distance=0
for step in $wire_two; do
  direction=${step:0:1}
  distance=${step:1}
  calc_trace $direction $distance cross
done

echo Answer: $min_distance