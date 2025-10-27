#!/bin/bash

set -ouex pipefail

PROG="$(basename "$BASH_SOURCE")"

DEFAULT_USER_FONT_DIR="${XDG_DATA_HOME:-"$HOME"/.local/share}"/fonts
DEFAULT_SYSTEM_FONT_DIR=/usr/local/share/fonts

print_help () {
	cat <<EOF
Usage: $PROG [OPTION...] FONT...

Install Nerd Fonts

Download and install fonts from the nerd fonts github.

options:
  -d, --install-dir DIR    override install dir (default: "$DEFAULT_USER_FONT_DIR")
      --system             install to system-wide install directories ("$DEFAULT_SYSTEM_FONT_DIR")
      --user               install to user install directories ("$DEFAULT_USER_FONT_DIR")
  -h, --help               print usage information and exit
EOF
}

main() {
	# Requires gnu enhanced getopt
	ARGS=$(getopt --name "$PROG" --long 'help,user,system,install-dir:' --options 'hd:' -- "$@")
	eval set -- "$ARGS"

	font_dir="$DEFAULT_USER_FONT_DIR"
	while [ $# -gt 0 ]; do
		case "$1" in
			-h | --help)
				print_help
				exit 0
				;;
			--user)
				font_dir="$DEFAULT_USER_FONT_DIR"
				;;
			--system)
				font_dir="$DEFAULT_SYSTEM_FONT_DIR"
				;;
			-d | --install-dir)
				shift
				font_dir="$1"
				;;
			--)
				shift
				break
				;;
		esac
		shift
	done

	if [ "$#" -lt 1 ]; then
		echo "No font family specified" >&2
		exit 1
	fi

	font_families=("$@")

	# Fetch the latest nerd fonts release version
	release_version="$(git ls-remote --tags https://github.com/ryanoasis/nerd-fonts \
		| cut -f 2 \
		| grep -P '^refs/tags/v([0-9]+\.){2}[0-9]+$' \
		| sed 's|refs/tags/||' \
		| sort --version-sort \
		| tail -n 1 \
	)"

	# Download all fonts
	for font_family in "${font_families[@]}"; do
		download_font_family "$font_dir" "$release_version" "$font_family"
	done

	# Update font cache
	fc-cache --force --verbose
}


download_font_family() {
	font_dir="$1"; shift
	release_version="$1"; shift
	font_family="$1"; shift

	mkdir -p "$font_dir"/"$font_family"
	curl -L --fail-with-body https://github.com/ryanoasis/nerd-fonts/releases/download/"$release_version"/"$font_family".tar.xz -o - \
		| tar -xJf - -C "$font_dir"/"$font_family"  # --wildcards "$font_family*.ttf"
}

main "$@"
