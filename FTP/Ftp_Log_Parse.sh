#!/bin/bash
# Program:
#        FTP Server check xferlog file
# History:
# 2016/05/23    Yiwei Shih      First release

# Please ignore the another shell "Ftp Log check".
# It is so stupid 

current_time=$(date +%s)

current_time_minus=`expr $current_time - 600`

readarray ftplog < /var/log/xferlog

for ((i=1; i<${#ftplog[@]}; i++))
do
        year=$(echo ${ftplog[$i]} | awk '{print $5}')
        mon=$(echo ${ftplog[$i]}  | awk '{print $2}')
        mon=$(date -d "$mon 1" +%m)
        day=$(echo ${ftplog[$i]} | awk '{print $3}')
        time=$(echo ${ftplog[$i]} | awk '{print $4}')
        upload_time="$year-$mon-$day $time"
        upload_time=$(date --date="$upload_time" +%s)
        if [ "$current_time" -ge "$upload_time" ] && [ "$upload_time" -ge "$current_time_minus" ]
        then
                upload_user=`echo ${ftplog[$i]} | awk '{print $14}'`
                upload_file=`echo ${ftplog[$i]} | awk '{print $9}'`
                upload_time=`echo ${ftplog[$i]} | awk '{print $4}'`
                upload_ip=`echo ${ftplog[$i]} | awk '{print $7}'`
                echo "=====================================================" >> Ftp_Log_report
                echo "User:$upload_user" >> Ftp_Log_report
                echo "Upload File: $upload_file" >> Ftp_Log_report
                echo "Upload Time: $upload_time" >> Ftp_Log_report
                echo "Upload IP: $upload_ip" >> Ftp_Log_report
        fi
done

if [ -f ./Ftp_Log_report ]; then

        cat Ftp_Log_report | unix2dos | mutt -s "New File Upload Ftp" yiweis@sparqtron.com
        rm -f ./Ftp_Log_report
fi
