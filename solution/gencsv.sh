#!/bin/bash +e

#create file
touch inputFile

for ((i=0;i<10;i+=1))
do
 echo "${i}, $RANDOM" >> inputFile
done
while true; do sleep 1; done

