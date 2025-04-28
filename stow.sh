#!/bin/bash

for dir in */; do                     # list directories in the form "dirname/"
  dir=${dir%*/}                       # remove the trailing "/"
  rm -rf "$HOME"/.config/"${dir##*/}" # delete existing config
  stow "${dir##*/}"                   # run stow for each directory

  if [ "$dir" == "fast-syntax-highlighting/" ]; then
    fast-theme "$HOME"/.oh-my-zsh/custom/plugins/fast-syntax-highlighting/themes/catppuccin-macchiato
  fi
done
