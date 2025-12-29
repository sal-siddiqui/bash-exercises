#!/usr/bin/env bash

get_size() {
	wc -c <"$1"
}

echo "> Welcome to the Interactive File and Directory Explorer!"
echo

echo "> Files and Directories in the Current Path:"
for item in ./*; do
	echo "  >> $(basename "$item") ($(get_size "$item")b)"
done
echo

while true; do
	read -p "> Enter a line of text (Press Enter without text to exit): " input

	if [[ -z "$input" ]]; then
		echo "> Exiting the Interactive Explorer. Goodbye!"
		break
	fi

	character_count=$(echo -n "$input" | wc -m)
	echo "> Character count: $character_count"
	echo
done
