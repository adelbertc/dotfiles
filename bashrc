#!/bin/bash

# source files
for f in $(ls ~/.source_these/*);
do
    . $f
done

# bash prompt
PS1='\w$(__git_ps1 " : %s")\nlocal ☯ '

# vi editing on command line
set -o vi
