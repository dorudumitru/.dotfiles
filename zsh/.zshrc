export GIT_EDITOR=nvim
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.local/share/bin
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="robbyrussell"

plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	vi-mode
)

ZSH_DISABLE_COMPFIX=true

source $ZSH/oh-my-zsh.sh

### User configuration ###
bindkey -s "^f" "tmux-sessionizer\n"

function idea { ( intellij "$@" & ) > /dev/null 2>&1 }
function land { ( goland "$@" & ) > /dev/null 2>&1 }
function rider { ( jbrider "$@" & ) > /dev/null 2>&1 }
function storm { ( webstorm "$@" & ) > /dev/null 2>&1 }
# function lion { ( clion "$@" & ) > /dev/null 2>&1 }

function visualvm {
  ( /opt/visualvm_217/bin/visualvm --fontsize 20 "$@" & ) > /dev/null 2>&1
}

alias vim='nvim'
alias ts='tmux-sessionizer'
alias fp='. project-finder'
alias vsvim='. vscode-vim-switcher'
alias gomake='. go-makefiler'
alias cato='cato-sdp'

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
export PATH=$PATH:$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet/tools
export DOTNET_CLI_TELEMETRY_OPTOUT=true

# sdkman
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# fzf
source /usr/share/fzf/shell/key-bindings.zsh
