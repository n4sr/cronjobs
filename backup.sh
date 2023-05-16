#!/usr/bin/bash
# Simple Backup Script
# usage: ./backup.sh <source> <destination> <number of backups to keep>

src=$1
dest=$2
number_of_backups=$3

# Check that variables are populated before continuing
# TODO: add checks for if the path to backup exists. potentially require absolute paths.
if [[ -z $src ]] || [[ -z $dest ]] || [[ $number_of_backups -le 0 ]]; then
    echo 'usage: ./backup.sh <source> <destination> <number of backups to keep>'
    exit 1
fi

# Create the new backup
new_backup="$dest/$(date +%F_%H.%M.%S.tar.gz)"
cd $src && tar -caf $new_backup *

# If the number of backups exceeds the limit, then remove the oldest file based on name.
# TODO: sort files based on created/modified time so the file naming convention can be more customizable
backups_to_remove=$(ls $dest | grep '.tar.gz$' | head -n -$number_of_backups)
cd $dest && if [[ -n $backups_to_remove ]]; then rm $backups_to_remove; fi
