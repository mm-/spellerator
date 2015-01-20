# spellerator
Simple script to speed up spellchecking git projects

Just a find loop with hunspell right now. Adding more features shortly ( hopefully ).

Slightly more features added.

The overall goal of this little script is to facilitate quickly checking a projects text saving unrecognized words in hunspell's private dictionary ( pressing i ), and then save that generated private dictionary for later use checking the same project again.

Untested, but the script will now backup any existing private dictionary and then save that file using the project name to a .spellerator directory in the users home for later use.

