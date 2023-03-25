#!/usr/bin/bash
# Backup cronjob
backup_target_dir=$1
backup_dir=$2
number_of_backups=$3

# Check that variables are populated before continuing
# TODO: add checks for if the path to backup exists. potentially require absolute paths.
if [[ -z $backup_target_dir ]] || [[ -z $backup_dir ]] || [[ $number_of_backups -le 0 ]]; then
    echo "something was misconfigured.. check shell script and try again"; exit 1
fi

# Create the new backup
new_backup="$backup_dir/$(date +%F_%H.%M.%S.tar.gz)"
cd $backup_target_dir && tar -caf $new_backup *

# If the number of backups exceeds the limit, then remove the oldest file based on name.
# TODO: sort files based on created/modified time so the file naming convention can be more customizable
backups_to_remove=$(ls $backup_dir | head -n -$number_of_backups)
cd $backup_dir && if [[ -n $backups_to_remove ]]; then rm $backups_to_remove; fi
