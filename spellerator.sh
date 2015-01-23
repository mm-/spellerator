#!/bin/bash
# Spell check a project 

dir=$1
srhome="$HOME/.spellerator"
library="$srhome/library"
dicthome="$srhome/dicts"
hsdefault="$HOME/.hunspell_en_US"
# This var gets the last directory out of a path string, ie "/home/user/jank/github/myproject" becomes "myproject"
project_name=$(echo $dir | awk 'BEGIN { FS = "/" } ; { print $NF }')



first_run(){

    # TODO: Extend this to automatically place dictionary files from /dicts into $dicthome
    
    
# Create library dir if needed
if [ -d $library ]
    then
    echo "Library directory exists"
    else
    echo "Creating initial library directory"
    mkdir $library
fi

}


startup(){
# Use existing personal dict if available
if [ -f $library/$project_name ]
    then
    echo "Using existing dictionary from library for project: $project_name"
    cp $library/$project_name $hsdefault
fi

# Make a backup of existing hunspell private dictionary if need be
if [ -f $hsdefault ]
    then
    echo "Private dictionary for hunspell exists, backing it up to .bak"
    mv $hsdefault $hsdefault.bak
fi
}

check_files(){
# Main loop, run hunspell against every ASCII file in specified dir

for file in $(find $dir -path $dir/.git -prune -o -type f -exec file -F "" {} + | grep 'ASCII\|UTF-8' | awk '{ print $1 }') 
  do
    echo $file
    hunspell $file
  done	
}


end(){
# Rename and move our file to library                                                                                                                                               
echo "Saving your custom dictionary for later use"
echo "It will be available in $library/$project_name"

mv $hsdefault $library/$project_name
}




## Run ##

#TODO: check for actual first run
first_run
startup
check_files
end




