#!/usr/bin/env bash
#
# Usage:
# ./diceware.sh 4 " " 5
# To print 4 random diceware words and 5 random numbers separated by a space.

reps=$1
sep=$2
extra=$3

echo "Generating phrase with $reps repetitions and \"$sep\" seperator, plus $extra extra random numbers between 0 and 999 inclusive..."

for i in $(seq 1 $reps)
do
  num=$((($(od -vAn -N2 -tu2 < /dev/urandom) % 7776) + 1))
  pass[$i]="$(sed "${num}q;d" diceware.wordlist)"
done

for i in $(seq 1 $extra)
do
  pass[$(($reps + $i))]=$(($(od -vAn -N2 -tu2 < /dev/urandom) % 1000))
done

echo $( IFS=$sep ; echo "${pass[*]}" )
