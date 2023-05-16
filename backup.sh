#!/usr/bin/bash
# Backup cronjob
# usage: ./backup.sh <source> <destination> <number of backups to keep>

# Check that variables are populated before continuing
if [[ -z $1 ]] || [[ -z $2 ]] || [[ $3 -le 0 ]]; then
    echo 'usage: ./backup.sh <source> <destination> <number of backups to keep>'
    exit 1
fi

dest="$2/$(basename $1)~$(date +%F_%R:%S).tar.gz"

cd $1 && tar -caf $dest *

# If the number of backups exceeds the limit, then remove the oldest file based on name.
backups_to_remove=$(ls $2 | grep -E "$(basename $1).*\.tar\.gz$" | head -n -$3)
cd $2 && if [[ -n $backups_to_remove ]]; then rm $backups_to_remove; fi
