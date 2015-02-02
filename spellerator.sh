#!/bin/bash
# Spell check a project 

#dir=$1
srhome="$HOME/.spellerator"
library="$srhome/library"
dicthome="$srhome/dicts"
hsdefault="$HOME/.hunspell_en_US"
# This var gets the last directory out of a path string, ie "/home/user/jank/github/myproject" becomes "myproject"
project_name=$(echo $dir | awk 'BEGIN { FS = "/" } ; { print $NF }')




first_run(){

echo "First run, building out spellerator home dir"  
    
# Create library dir if needed
if [ -d $library ]
    then
    echo "Library directory exists, moving on"
    else
    echo "Creating initial library directory"
    mkdir -p $library
    cp -R dicts $srhome/.
fi

}



startup(){
# Make a backup of existing hunspell private dictionary if need be                                                                                                                  
if [ -f $hsdefault ]
    then
    echo "Private dictionary for hunspell exists, backing it up to .bak"
    mv $hsdefault $hsdefault.bak
fi



# Use existing personal dict if available
if [ -f $library/$project_name ]
    then
    echo "Using existing dictionary from library for project: $project_name"
    cp $library/$project_name $hsdefault
fi

}



check_files(){
# Main loop, run hunspell against every ASCII file in specified dir

for file in $(find $dir -path $dir/.git -prune -o -type f -exec file -F "" {} + | grep 'ASCII\|UTF-8' | awk '{ print $1 }') 
  do
    hunspell -d $dicthome/en_US $file
  done	
}




end(){
# Rename and move our file to library                                                                                                                                               
echo "Saving your custom dictionary for later use"
echo "It will be available in $library/$project_name"

mv $hsdefault $library/$project_name
}




## Run ##

while [[ $# > 1 ]]
do
key="$1"

case $key in
    -d|--directory)
    dir="$2"
    shift
    ;;
    -p|--projectname)
    project_name="$2"
    shift
    ;;
    -h|--help)
	echo "Specify the directory to check with -d and optional project name to refer to in the future with -p" 
    ;;
    *)
    ;;
esac
shift
done


# Check if first run
if [ ! -d $srhome ]
then
    first_run
fi

# Run through
startup
check_files
end




