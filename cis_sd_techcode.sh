#!/usr/bin/ksh
#Author: AC Perdon
#Date: 2013.06.05
#Purpose: Automatically download techcode file from Direct 
#and automatically load data via uv program every 2AM. 
#Change History:
#2013.06.05 - Initial 
#
#########################################################################  

## Variables. 
expect_log="/path/bin/cis_script/expect_log"


## Start downloading the Techcode file from solve direct. 
/usr/bin/expect << EOF >> ${expect_log} 
spawn sftp <sFTP-ID>@<remote-server>
expect "password:"
send "<password>\n"
expect "sftp>"
send "lcd /download/folder/\n"
expect "sftp>"
send "cd remote_download_folder/\n"
expect "sftp>"
send "get <file_to_download\n"
expect "sftp>"
send "rm <delete_file_that_was_download>\n"
expect "sftp>"
send "exit\r"
EOF


grep "not found" ${expect_log}  ##Check if the file was downloaded or not.

## Once downloaded it will rename the file to Tech_ABC.txt and change its permission then it will load it via uv program.
if [ ${?} -ne 0 ]; then
	mv /path/dir/tech/file_that_was_download.csv /path/dir/tech/New_filename_that_was_download.txt
	chmod 666 /path/dir/tech/New_filename_that_was_download.txt
	cat /dev/null > ${expect_log}

    ## Loading the data via uv program.
    cd /ibmdbms/IBM.CISCO
    /usr/lpp/uv/bin/uv "PHANTOM CISCO.LOAD.TECH IBM.CISCO"
else
   cat /dev/null > ${expect_log}
   exit
fi 


##END
