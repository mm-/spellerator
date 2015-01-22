# spellerator
Simple script to speed up spellchecking git projects using hunspell and some bash

The overall goal of this little script is to facilitate quickly spell checking a project while saving unrecognized words in hunspell's private dictionary ( pressing i ), and to then save that generated private dictionary for later use checking the same project again.

The script will backup any existing private dictionary and then save that file using the project name to a .spellerator directory in the users home for later use.

