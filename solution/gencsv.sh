#!/bin/bash 

#remove if file with name inputFile exists and also dont fail the script if inputFile doesn't exists
rm inputFile || true

#create file
touch inputFile

for ((i=0;i<10;i+=1))
do
 echo "${i}, $RANDOM" >> inputFile
done

