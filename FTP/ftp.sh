#!/bin/bash

# Program:
#       Detective FTP server folder has whether new file  and inform user
# History:
# 2016/05/05    Yiwei Shih      First release


path="/home/yiwei/shell_test/file/"

mail=($(cat /home/yiwei/mail.txt))   #store cat contents in array

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
                echo "This is a test mail from ftp server" | mailx -s "File update inform" ${mail[$k]}
        done
exit
fi

