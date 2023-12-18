export PATH=$PATH:$HOME/.local/bin
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

# User configuration
bindkey -s "^f" "tmux-sessionizer\n"

function idea() { ( intellij "$@" & ) > /dev/null 2>&1 }
function land() { ( goland "$@" & ) > /dev/null 2>&1 }
function rider() { ( jbrider "$@" & ) > /dev/null 2>&1 }
function storm() { ( webstorm "$@" & ) > /dev/null 2>&1 }
function lion() { ( clion "$@" & ) > /dev/null 2>&1 }

alias vim='nvim'
alias vi='nvim'
alias fzf='fzf --prompt "❯ "'

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# git-completion
autoload -Uz compinit && compinit

# go doc color
export GDOC_STYLE=monokai

# jetbrains
export PATH=$PATH:/home/ketutz/.local/share/bin
export PATH=$PATH:/home/ketutz/.local/bin

# starship
eval "$(starship init zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# go
export PATH=$PATH:/usr/local/go/bin # no need to set this if go is installed with dnf
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# .NET
export DOTNET_ROOT=$HOME/.dotnet
export PATH=$PATH:$HOME/.dotnet:$HOME/.dotnet/tools
export DOTNET_CLI_TELEMETRY_OPTOUT=true

# sdkman
export SDKMAN_DIR="/home/$(whoami)/.sdkman"
[[ -s "/home/$(whoami)/.sdkman/bin/sdkman-init.sh" ]] && source "/home/$(whoami)/.sdkman/bin/sdkman-init.sh"

# pnpm
export PNPM_HOME="/home/$(whoami)/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# Load Angular CLI autocompletion.
source <(ng completion script)

# bun completions
[ -s "/home/$(whoami)/.bun/_bun" ] && source "/home/$(whoami)/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
