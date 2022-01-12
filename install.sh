#!/bin/sh

rules_file="rules"

set -e

link_to () {
	base="$(dirname $(realpath $0))"
	if [[ -z $base ]]; then
		echo "please run this script inside of .dotfile folder"
		exit 1
	fi
	src="$base/$1"
	dst="$2"
	for file in $src/*; do
		target="$src/$(basename $file)"
		link=$(ls "$dst/$(basename $file)")
		ln -P "$target" "$link"
	done
}

shopt -s dotglob
while read line; do
	link_to $(echo $line | awk '{print $1}') $(echo $line | awk '{print $2}')
done < "$rules_file"
