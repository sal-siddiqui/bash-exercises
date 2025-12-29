#!/usr/bin/env bash

# Validate arguments
if [ $# -eq 0 ] || [ ! -d "$1" ]; then
	echo "> Error: Please provide a valid directory as an argument"
	exit 1
fi
src_dir="$1"

# Helper function: Create the actual backup
create_backup() {
	local timestamp=$(date '+%Y-%m-%d_%H-%M-%S')
	local backup_dir="${src_dir}/backup-${timestamp}"

	mkdir "$backup_dir"
	echo "> Backup created successfully: $backup_dir"
}

# Helper function: Rotate to only keep the 3 most recent backups
rotate_backups() {
	local backups=($(ls -dt ${src_dir}/backup-*))

	count=${#backups[@]}

	if ((count > 3)); then
		for dir in "${backups[@]:3}"; do
			rm -rf "$dir"
			echo "  >> Removed old backup: $dir"
		done
	fi
}

# Main execution loop
main() {
	create_backup
	rotate_backups
}

main
