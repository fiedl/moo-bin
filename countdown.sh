#!/bin/sh
X=10
while [ $X -gt 0 ]
do
    echo "$X"
    X=$((X - 1))
    sleep 1
done
echo "moo!"

