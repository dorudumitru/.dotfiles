export PATH="$PATH:/opt/nvim-linux-x86_64/bin"
export GIT_EDITOR=nvim
export EDITOR=nvim
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/bin
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"
ZSH_DISABLE_COMPFIX=true

plugins=(
	git
	zsh-autosuggestions
  fast-syntax-highlighting
	vi-mode
)

source $ZSH/oh-my-zsh.sh

### User configuration ###
function idea { ( intellij "$@" & ) > /dev/null 2>&1 }
function land { ( goland "$@" & ) > /dev/null 2>&1 }
function rider { ( jbrider "$@" & ) > /dev/null 2>&1 }

function cursor {
  ( $HOME/Applications/cursor-*.AppImage "$@" & ) > /dev/null 2>&1
}

function visualvm {
  ( /opt/visualvm*/bin/visualvm --fontsize 20 "$@" & ) > /dev/null 2>&1
}

alias vim='nvim'
alias ts='tmux-sessionizer'
alias fp='. project-finder'
alias cato='cato-sdp'

# open tmux sessionizer with <C-f>
bindkey -s "^f" "ts\n"

# remove annoying error when using ssh
[ "$TERM" = "xterm-kitty" ] && alias ssh="kitty +kitten ssh"

# git-completion
autoload -Uz compinit && compinit

# starship
eval "$(starship init zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# go
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:/usr/local/go/bin # no need to set this if go is installed with dnf

# .NET
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$DOTNET_ROOT:$DOTNET_ROOT/tools
export DOTNET_CLI_TELEMETRY_OPTOUT=true

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# pnpm
export PNPM_HOME="/home/doru.dumitru/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# fzf
source /usr/share/fzf/shell/key-bindings.zsh
