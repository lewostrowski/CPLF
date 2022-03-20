# CPLF
Copy the last modified (downloaded) file form ~/Downloads to a working directory. 

#filemanagment #automation

MIT License

## USAGE
#### Structure
$ ./cplf.sh [option/new-file-name] [new-file-name]

***Providing filename twice will raise an error***.

#### Using script without oprtions/file name
The script will copy the last modified file in ~/Downloads into the working directory without removing or changing the original file's name. 
If a name already exists in the working directory, the script will raise an error.

#### Using script with first argument only
The first argument can be either:
1. New file name.
2. Option.

###### New file name
The script will copy the last modified file in ~/Downloads into the working directory without removing the original file. 
The file's name will be changed to a name provided in the first argument.
If a name already exists in the working directory, the script will raise an error.

###### Options
There are three options available:
1. Flag -o will override the already existing file. 
2. Flag -r will delete the original file from ~/Downloads
3. Flag -ro will execute both flags.

#### Using script with both arguments
To use simultaniosly a flag and to provide a new name, type ./cplf.sh [option] [new-file-name] and stick to previous parts. 
