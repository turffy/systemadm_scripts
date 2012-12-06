#!/usr/bin/ksh
#Author: AC Perdon
#Date: 2012.12.05
#Purpose: Extract AIX ids and there last log-ins.
#Change: Initial 

#Note: Run it as root.

#file=$(cat test_list)
file=$(cat passwd_list)

for list in $file
do
 user=$(grep -w "^$list" /etc/passwd | cut -d : -f 1,5 | sed 's/;/|/g' | sed 's/:/|/g') 
 echo "$user|\c"
 last_log=$(lsuser -a time_last_login "$list" | awk -F= '{print $2}')
 if [ ! -z "$last_log" ]
 then
        perl -e "print scalar(localtime("$last_log"))"
	echo "\n"
 else
	echo "no record of logging in server!"
	echo "\n"
 fi
done


#END
