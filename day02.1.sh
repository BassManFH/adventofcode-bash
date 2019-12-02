#!/bin/bash

input='./day02.input'

intcode="$(<"$input")"
intcode=( $(echo $intcode | tr "," " ") )

# before running the program, replace position 1 with the value 12 and replace position 2 with the value 2.
intcode[1]=12
intcode[2]=2

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

echo Answer: ${intcode[0]}