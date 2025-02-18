if command -v atuin &> /dev/null; then
  # atuin is installed package manager
  ATUIN_BIN=atuin
else
  # atuin is installed with official script: https://atuin.sh/
  export PATH=~/.atuin/bin:$PATH
  ATUIN_BIN=~/.atuin/bin/atuin
fi

eval "$($ATUIN_BIN init zsh)"
