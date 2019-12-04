#!/bin/bash

input='./day04.input'

check_number() {
  value=$1
  adjacent=1
  for (( position=0; position<${#value}-1; position++ )); do
    if [[ ${value:$position:1} -gt ${value:$position+1:1} ]]; then return 1; fi
    if [[ $adjacent -eq 1 ]]; then
      if [[ ${value:$position:1} -eq ${value:$position+1:1} ]]; then
        if [[ ${value:$position:1} -ne ${value:$position+2:1} ]]; then
          if [[ $position -eq 0 || ${value:$position:1} -ne ${value:$position-1:1} ]]; then
            adjacent=0
          fi
        fi
      fi
    fi
  done
  return $adjacent
}

input="$(<"$input")"
start=$(echo $input | cut -d- -f1)
end=$(echo $input | cut -d- -f2)

counter=0
for (( i=start; i<=end; i++)); do
  if check_number $i; then (( counter++ )); fi
done

echo Answer: $counter