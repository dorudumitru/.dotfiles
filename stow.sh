#!/bin/bash

for dir in */; do # list directories in the form "dirname/"
  if [ "$dir" == "vscode-keybindings/" ]; then
    rm "$HOME"/.config/Code/User/keybindings.json
  elif [[ $dir == "vscode-settings/" ]]; then
    rm "$HOME"/.config/Code/User/settings.json
  fi

  dir=${dir%*/}     # remove the trailing "/"
  stow "${dir##*/}" # run stow for each directory
done
