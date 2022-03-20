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
        echo "File copied with the name: $NEWNAME"
}

preserveName(){
        cp ~/Downloads/$FILE $WORKDIR/$FILE
}

#removing old file
removeOld(){
        rm ~/Downloads/$FILE
        echo "Original file deleted"
}



#checking for arguments
if [[ -n $1 && -n $2 ]]; then
        if [[ "$1" = "-r" || "$1" = "-o" || "$1" = "-ro" ]]; then
                NEWNAME=$2
                #remove option
                if [[ "$1" = "-r" && -e $NEWNAME ]]; then
                        echo "Error. File already exists in working directory"
                elif [[ "$1" = "-r" && ! -e $NEWNAME ]];then
                        changeName
                        removeOld

                #override option
                elif [[ -e $NEWNAME && "$1" = '-o' ]];then
                        changeName
                        echo "Old file in working directory overridden"
                elif [[ ! -e $NEWNAME && "$1" = '-o' ]];then
                        changeName
                        echo "Nothing to override"

                #remove/override optoions
                elif [[ -e $NEWNAME && "$1" = '-ro' ]]; then
                        changeName
                        removeOld
                        echo "File copied. Name Changed. Old file deleted. Old file overrided"
                elif [[ ! -e $NEWNAME && "$1" = '-ro' ]]; then
                        changeName
                        removeOld
                        echo "File copied. Name Changed. Old file deleted. Nothing to override"
                        
                fi
        else
                echo "Unvalid option"
        fi
elif [[ -n $1 && -z $2 ]]; then
        #remove option
        if [[ "$1" = "-r" && -e $FILE ]]; then
                echo "Error. File already exist in working directory"
        elif [[ "$1" = "-r" && ! -e $FILE ]];then
                preserveName
                removeOld
                echo "File copied. Old name preserved. Old file deleted"

        #override option
        elif [[ "$1" = "-o" && -e $FILE ]];then
                preserveName
                echo "File copied. Old name preserved. Old file overrided"
        elif [[ "$1" = "-o" && ! -e $FILE ]];then
                preserveName
                echo "File copied. Old name preserved. Nothing to override"

        #remove/override optoions
        elif [[ "$1" = "-ro" && -e $FILE ]]; then
                preserveName
                removeOld
                echo "File copied. Old name preserved. Old file deleted. Old file overrided"
        elif [[ "$1" = "-ro" && ! -e $FILE ]]; then
                preserveName
                removeOld
                echo "File copied. Old name preserved. Old file deleted. Nothing to override"

        #change name without options
        elif [[ "$1" != "-r" || "$1" != "-o" || "$1" != "-ro" ]]; then
                NEWNAME=$1
                if [[ ! -e $NEWNAME ]];then
                        changeName
                else
                        echo "File with provided name already exist"
                fi 
        
        #error code
        else
                exit "Unknown error"
        fi

else
        #simple copy without options and new name
        if [[ -e $FILE ]]; then
                echo "Error. File already exist in working directory"
        else
                preserveName
                echo "File copied. Old name preserved"
        fi
fi
