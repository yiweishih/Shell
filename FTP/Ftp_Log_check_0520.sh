#!/bin/bash
#
#!/bin/bash
# Program:
#          FTP Server check xferlog
# History:
# 2016/05/19	Yiwei Shih	First release
# 2016/05/20    Yiwei Shih  Second release

current_month=`date | awk '{print $2}'`
current_day=`date | awk '{print $3}'`
current_hour=`date | awk '{print $4}' | awk -F: '{print $1}'`
current_minute=`date | awk '{print $4}' | awk -F: '{print $2}'`

readarray ftplog < /var/log/xferlog

for ((i=1; i<${#ftplog[@]}; i++))
do

	upload_month=`echo ${ftplog[$i]} | awk '{print $2}'`
	upload_day=`echo ${ftplog[$i]} | awk '{print $3}'`
	upload_hour=`echo ${ftplog[$i]} | awk '{print $4}' | awk -F: '{print $1}'`
	upload_minute=`echo ${ftplog[$i]} | awk '{print $4}' | awk -F: '{print $2}'`
	current_minute_minus=`expr $current_minute - 10`
	upload_hour_plus=`expr $upload_minute + 1`
	upload_day_plus=`expr $upload_day + 1`

	if [ "$current_hour" == 00 ] && [ "$upload_hour" == 23 ] && [ "$upload_day_plus" == "$current_day" ] \
	&& [ 59 -gt "$upload_hour" ] && [ "$upload_hour" -gt 50 ]
	then
		upload_user=`echo ${ftplog[$i]} | awk '{print $14}'`
		upload_file=`echo ${ftplog[$i]} | awk '{print $9}'`
		echo "User:$upload_user upload file $upload_file" >> Ftp_Log_report
	

	elif [ "$upload_month" == "$current_month" ] && [ "$upload_day" == "$current_day" ] && [ "$current_minute" == "00" ] \
	&& [ "$current_hour" == "$upload_hour_plus" ] && [ 59 -gt "$upload_hour" ] && [ "$upload_hour" -gt 50 ]
        then        
		upload_user=`echo ${ftplog[$i]} | awk '{print $14}'`
                upload_file=`echo ${ftplog[$i]} | awk '{print $9}'`
                echo "User:$upload_user upload file $upload_file" >> Ftp_Log_report

	elif [ "$upload_month" == "$current_month" ] && [ "$upload_day" == "$current_day" ] && [ "$upload_hour" == "$current_hour" ] \
        && [ "$current_minute" -ge "$upload_minute" ] && [ "$upload_minute" -ge "$current_minute_minus" ]
        then
		upload_user=`echo ${ftplog[$i]} | awk '{print $14}'`
		upload_file=`echo ${ftplog[$i]} | awk '{print $9}'`
		echo "User:$upload_user upload file $upload_file" >> Ftp_Log_report
	fi
done	 


if [ -f ./Ftp_Log_report ]; then

	cat Ftp_Log_report | unix2dos | mutt -s "New File Upload Ftp" yiweis@sparqtron.com
	rm -f ./Ftp_Log_report
fi


