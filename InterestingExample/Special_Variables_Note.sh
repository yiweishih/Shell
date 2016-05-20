#!/bin/bash

echo \$0:$0   #The filename of the current script.

echo \$1:$1   #These variables correspond to the arguments with which a script was invoked.
echo \$2:$2   #Here n is a positive decimal number corresponding to the position of an argument
echo \$3:$3   #(the first argument is $1, the second argument is $2, and so on).

echo \$\*:$*  #All the arguments are double quoted. If a script receives two arguments, $* is equivalent to $1 $2.
echo \$\@:$@  #All the arguments are individually double quoted. If a script receives two arguments, $@ is equivalent to $1 $2.

echo \$\?:$?  #The exit status of the last command executed.
echo \$\$:$$  #The process number of the current shell. For shell scripts, this is the process ID under which they are executing.
echo \$\!:$!  #The process number of the last background command.
echo \$\_:$_  #Gives the last argument to the previous command. At the shell startup, it gives the absolute filename of the shell script being executed.
echo \$\-:$-  #Options set using set builtin command



# Reference:http://www.thegeekstuff.com/2010/05/bash-shell-special-parameters/#comments
