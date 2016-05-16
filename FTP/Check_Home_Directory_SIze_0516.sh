#!/bin/bash
# Program:
#          FTP Server Home directory check and inform Administrator
# History:
# 2016/05/13	Yiwei Shih	First release
# 2016/05/16	Yiwei Shih 	Second release

path=/home/

echo `du --max-depth=1 $path | sort -hr >> ./result.txt`

# Read lines from the standard input into the indexed array variable array
# If I did not use readarray, type like this:
# result=$((cat result.txt))
# The result will show as below:  
# ${result[0]=123456
# ${result[1]=/home
# If I want to show result as below:
# ${result[0]=123456 /home 
# ${result[1]=567890 /home/sparq08

readarray result < result.txt  # create an array where each element of the array is a line in the input.

for ((i=1; i<${#result[@]}; i++)); do
        user_size=`echo ${result[$i]} | awk '{print int($1)}'`
        user_account=`echo ${result[$i]} | awk '{print $2}' | awk -F"/" '{print $3}' | grep "sparq*"`   # Use path to catch user account name
        if [ "$user_size" -gt 102400 ]	
        then
                user_size=$(($user_size/1024))		
                echo "Size of $user_account is $user_size MB, it over than 100 MB" >> size_report.txt
        fi
        done

# cat size_report.txt | unix2dos | mail -s "Ftp Home Directory Check" yiweis@sparqtron.com 
# But instead of receiving the content of file in the mail i got an attachment with name AT00001.bin
# The SMTP specification says that end-of-line in SMTP messages is \r\n   (return+newline)
# where in Unix/Linux the end of line is \n  (newline)
# Run the text though a tr filter to convert all the \n to \r\n -- or pipe it through unix2dos which does the same thing, like;
# Thanks Soren http://stackoverflow.com/questions/37199671/incorrect-format-of-sending-mail-from-linux-shell/37205772#37205772


		
cat size_report.txt | unix2dos | mutt -s "Ftp Home Directory Check" yiweis@sparqtron.com

rm -f ./size_report.txt
rm -f ./result.txt
