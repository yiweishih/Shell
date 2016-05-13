#!/bin/bash

# Program:
#       Detective FTP server folder has whether new file  and inform user
# History:
# 2016/05/05    Yiwei Shih      First release
# 2016/05/09	Yiwei Shih		Second release


path="/home/sparq02/"

mail=($(cat /home/sparq02/mail.txt))   #store cat contents in array

folder="`date +%b`_`date +%Y`"

arr=($( find $path -maxdepth 1 -name "*.pdf"))


if [ ${#arr[@]} != 0 ]; then                                    #if array is not equal null
        for ((i=0; i<${#arr[@]}; i++)); do                      #"${#arr[@]}" means length of array
                if [ -d $path$folder ]; then
                        mv ${arr[$i]} $path$folder
                else
                        mkdir $path$folder && mv ${arr[$i]} $path$folder
                fi
        done
        for ((k=0; k<${#mail[@]}; k++)); do
                if [ "${#arr[@]}" > 1 ]; then
                        echo "Today, we got ${#arr[@]} packing slips" | mail -s "File update inform" ${mail[$k]}
                else
                        echo "Today, we got ${#arr[@]} packing slip" | mail -s "File update inform" ${mail[$k]}
                fi
         done
exit
fi

#If I assign internal email address to send mail, the other internal email will not recevie mail, external mail is OK ! Why?
#For example:
#echo "Test mail" | mail -r IT@sparqtron.com -s "This is test mail" aaa@gmail.com  ===> It worked
#echo "Test mail" | mail -r IT@sparqtron.com -s "This is test mail" bbb@sparqtron.com  ===> It not worked