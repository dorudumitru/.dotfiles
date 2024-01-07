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

function idea { ( intellij "$@" & ) > /dev/null 2>&1 }
function land { ( goland "$@" & ) > /dev/null 2>&1 }
function rider { ( jbrider "$@" & ) > /dev/null 2>&1 }
function storm { ( webstorm "$@" & ) > /dev/null 2>&1 }
function lion { ( clion "$@" & ) > /dev/null 2>&1 }

function ur {
  unzip $1 -d $2
  rm $1
}

function vsvim {
  if [ $1 = enable ]; then
    selected=$(find -L ~/.config/nvim -mindepth 1 -maxdepth 1 -type d -name "lua")
    selected_name=$(basename "$selected")

    if [ "$selected_name" != "lua" ]; then
      echo "vsvim already enabled"
      return
    fi

    mv ~/.config/nvim ~/.config/nvim.lazy
    cp -r ~/.dotfiles/nvim.vscode ~/.config/nvim
  elif [ $1 = disable ]; then
    selected=$(find -L ~/.config/nvim -mindepth 1 -maxdepth 1 -type d -name "lua")
    selected_name=$(basename "$selected")

    if [ "$selected_name" = "lua" ]; then
      echo "vsvim already disabled"
      return
    fi

    rm -rf ~/.config/nvim
    mv ~/.config/nvim.lazy ~/.config/nvim
  else
    echo "invalid argument"
    return
  fi
}

alias vim='nvim'
alias fzf='fzf --prompt "❯ "'
alias ts='tmux-sessionizer'

alias ls='lsd'
alias l='ls -l'
alias la='ls -a'
alias lla='ls -la'
alias lt='ls --tree'

# git-completion
autoload -Uz compinit && compinit

# jetbrains
export PATH=$PATH:/home/$(whoami)/.local/share/bin
export PATH=$PATH:/home/$(whoami)/.local/bin

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

# fzf
source /usr/share/fzf/shell/key-bindings.zsh
