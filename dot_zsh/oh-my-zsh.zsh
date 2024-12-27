ZSH=$HOME/.oh-my-zsh

ZSH_THEME="powerlevel10k/powerlevel10k"

COMPLETION_WAITING_DOTS="true"

plugins=(
  git
  golang
  rust
  docker
  kubectl
  vi-mode
  zsh-autosuggestions
  zsh-syntax-highlighting
  z
)

DISABLE_AUTO_UPDATE=true

source $ZSH/oh-my-zsh.sh
