#!/usr/bin/env bash
# Run as 'root' to perform the create, delete, and reset operations

function display_usage() {
	echo "Usage: $0 <commands> [args]"
	echo "Commands: "
	echo "create <username>	Create a new user account"
	echo "delete <username>	Delete an existing user account"
	echo "reset <username>	Reset the password for a user"
	echo "list			List all the users"
	echo "help			Show this help message"
}

function does_user_exist() {
	username="$1"
	id "$username" &>/dev/null
}

function create_user() {
	username=$1
	if does_user_exist "$username"; then
		echo "> Username '$username' already exists"
		exit 1
	fi

	read -rp "> password: " password

	useradd -m "$username"
	echo "${username}:${password}" | chpasswd

	echo "> Account '$username' created"
}

function delete_user() {
	username=$1
	if ! does_user_exist "$username"; then
		echo "> Username '$username' does not exist"
		exit 1
	fi

	userdel -r "$username" &>/dev/null
	echo "> Account '$username' deleted"
}

function reset_password() {
	username=$1
	if ! does_user_exist "$username"; then
		echo "> Username '$username' does not exist"
		exit 1
	fi

	read -rp "> password (new): " password
	echo "${username}:${password}" | chpasswd # <-- Gemini

	echo "> Password reset for '$username'"
}

function list_users() {
	awk -F: '$3 >= 1000 && $3 != 65534 {print $1}' /etc/passwd # <-- Gemini
}

# Program execution begins from here
function main() {

	cmd=$1
	shift

	case "$cmd" in
	create) create_user "$@" ;;
	delete) delete_user "$@" ;;
	reset) reset_password "$@" ;;
	list) list_users ;;
	*) display_usage ;;
	esac

}
main "$@"
