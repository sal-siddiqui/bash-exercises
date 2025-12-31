#!/usr/bin/env bash

script="$0"
log_file="$1"

function main() {
	if (($# != 1)); then
		echo "Usage: $script <file>"
		exit 1
	fi

	if ! [ -e "$log_file" ]; then
		echo "> ${log_file@Q} does not exist."
		exit 1
	fi

	total_lines=$(wc -l <"$log_file")
	error_count=$(grep -i -c "error" "$log_file")

	echo total_lines error_count
}
main "$@"
