#!/bin/bash

input='./day02.input'

initial_state="$(<"$input")"
initial_state=( $(echo $initial_state | tr "," " ") )

noun=0
verb=0

while true; do
  intcode=("${initial_state[@]}")
  intcode[1]=noun
  intcode[2]=verb
  index=0
  while true; do
    opcode=${intcode[$index]}
    if [[ $opcode -eq 99 ]]; then
      break
    else
      input_one=${intcode[$index+1]}
      input_two=${intcode[$index+2]}
      output=${intcode[$index+3]}
      if [[ $opcode -eq 1 ]]; then
        (( intcode[output] = intcode[input_one] + intcode[input_two] ))
      else
        (( intcode[output] = intcode[input_one] * intcode[input_two] ))
      fi
    fi
    (( index += 4 ))  
  done
  if [[ ${intcode[0]} -eq 19690720 ]]; then
    echo Answer: $(( 100 * noun + verb ))
    break
  fi
  (( verb++ ))
  if [[ $verb -eq 100 ]]; then
    (( noun++ ))
    verb=0
  fi
done
