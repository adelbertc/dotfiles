#!/bin/bash

# source files
for f in $(ls ~/.source_these/*);
do
    . $f
done

# bash prompt
PROMPT_COMMAND='__git_ps1 "\w" "\nlocal ☯ "'

# vi editing on command line
set -o vi
