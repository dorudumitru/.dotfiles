#!/bin/bash

for dir in */; do # list directories in the form "dirname/"
	if [ $dir == "nvim.vscode/" ]; then
		continue
	fi

	dir=${dir%*/}     # remove the trailing "/"
	stow "${dir##*/}" # run stow for each directory
done
