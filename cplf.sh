#!/bin/bash

#check last downloaded file's name
WORKDIR=$(pwd)
cd ~/Downloads
FILE=$(ls -t | head -n 1)
echo "Original name: $FILE"
cd $WORKDIR

#changing name functions
changeName(){
        cp ~/Downloads/$FILE $WORKDIR/$NEWNAME
        echo "File copied with a new name: $NEWNAME"
}

preserveName(){
        cp ~/Downloads/$FILE $WORKDIR/$FILE
        echo "File copied with a original name: $FILE"
}

#removing old file
removeOld(){
        rm ~/Downloads/$FILE
        echo "Original file deleted"
}

#messages
ALREADYEXIST="Error. File already exists in working directory"
OLDOVERRIDEN="Old file in working directory overridden"
NOOVERRIDE="Nothing to override"


#checking for arguments
if [[ -n $1 && -n $2 ]]; then
        if [[ "$1" = "-r" || "$1" = "-o" || "$1" = "-ro" ]]; then
                NEWNAME=$2
                #remove option
                if [[ "$1" = "-r" && -e $NEWNAME ]]; then
                        echo $ALREADYEXIST
                elif [[ "$1" = "-r" && ! -e $NEWNAME ]];then
                        changeName
                        removeOld

                #override option
                elif [[ -e $NEWNAME && "$1" = '-o' ]];then
                        changeName
                        echo $OLDOVERRIDEN
                elif [[ ! -e $NEWNAME && "$1" = '-o' ]];then
                        changeName
                        echo $NOOVERRIDE

                #remove/override optoion
                elif [[ -e $NEWNAME && "$1" = '-ro' ]]; then
                        changeName
                        removeOld
                        echo $OLDOVERRIDEN
                elif [[ ! -e $NEWNAME && "$1" = '-ro' ]]; then
                        changeName
                        removeOld
                        echo $NOOVERRIDE
                        
                fi
        else
                echo "Unvalid option"
        fi
elif [[ -n $1 && -z $2 ]]; then
        #remove option
        if [[ "$1" = "-r" && -e $FILE ]]; then
                echo $ALREADYEXIST
        elif [[ "$1" = "-r" && ! -e $FILE ]];then
                preserveName
                removeOld

        #override option
        elif [[ "$1" = "-o" && -e $FILE ]];then
                preserveName
                echo $OLDOVERRIDEN
        elif [[ "$1" = "-o" && ! -e $FILE ]];then
                preserveName
                echo $NOOVERRIDE

        #remove/override optoions
        elif [[ "$1" = "-ro" && -e $FILE ]]; then
                preserveName
                removeOld 
                echo $OLDOVERRIDEN
        elif [[ "$1" = "-ro" && ! -e $FILE ]]; then
                preserveName
                removeOld
                echo $NOOVERRIDE

        #change name without options
        elif [[ "$1" != "-r" || "$1" != "-o" || "$1" != "-ro" ]]; then
                NEWNAME=$1
                if [[ ! -e $NEWNAME ]];then
                        changeName
                else
                        echo $ALREADYEXIST
                fi 
        
        #error code
        else
                exit "Unknown error"
        fi
else
        #simple copy without options and new name
        if [[ -e $FILE ]]; then
                echo $ALREADYEXIST
        else
                preserveName
        fi
fi
