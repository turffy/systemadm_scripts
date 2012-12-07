#!/bin/ksh
#Author: Ac Perdon
#Date: 2012.11.25
#Purpose: kill mulitple process
#Change: Initial

process="$1"

for x in $(ps -ef | grep -v grep  | grep "$process" | awk '{print $2}')
do
 #echo $process
 kill -9 $x
done

#END
