#!/bin/bash

#check last downloaded file's name
cd ~/Downloads
FILE=$(ls -t | head -n 1)
echo "Original name: $FILE"

#changing name function
changeName(){
	cp ~/Downloads/$FILE $NEWNAME
}


#checking for name error and override mode
if [ -e $FILE ];
then
	if [ "$2" = "o"]:
	then
	
	else
		exit "Name already exist. Set override mode"
else
	echo "No errors"
	if [ "${#1}" -ge 1 ]; 
	then
		NEWNAME=$1
		echo "Seting new name to $1"
	else
		NEWNAME=$FILE
		echo "Preserving original name"
	fi
fi



