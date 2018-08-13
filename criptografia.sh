#!/bin/bash
n(){ echo "a b c d e f g h i j k l m n o p q r s t u v w x y z" | cut -d"$1" -f1 | tr " " "\n" | wc -l ; }

la(){ echo "A B C D E F G H I J L M N O P Q R S T U V W X Y Z" | cut -d" " -f$((($RANDOM%25)+1)); }

if [ "$1" == "" ]; then
  exit;
fi
ent=$1
echo
echo "Argumento recebido: $ent"
echo
p1="$(echo $ent | tr "abcdefghijklmnopqrstuvwxyz" "zyxwvutsrqponmlkjihgfedcba")"
p2="$(echo $p1 | tr " " ":")"
p3="$(echo $p2 | tr "\n" "@")"

p4="$(for a in $(seq $(echo -n "$p3" | wc -c)); do
  carac="$(echo "$p3" | cut -b $a)"
  il="$(echo $carac | grep "[a-z]")"

  if [ "$il" != "" ]; then
    n $carac
  else
    echo "$carac"
  fi
done | tr "\n" " ")"

p5="$(for a in $p4; do
  in="$(echo $a | grep "[1-9]")"
  if [ "$in" != "" ]; then
    let count++
    echo -n "$(($a*$count))$(la)"
  else
    echo -n "$a$(la)"
  fi
done)"

echo $p5
echo
