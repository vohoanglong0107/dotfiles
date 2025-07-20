# For menu-selection. Must be loaded before calling compinit
zmodload zsh/complist

autoload -Uz compinit; compinit

# Can prompt completion menu when the cursor is in the middle a the word
setopt COMPLETE_IN_WORD

# Yes to always enable menu completion, select=2 to enter menu selection only
# when there are 2 or more options
zstyle ':completion:*' menu select=2 yes

# file extenstion and approximate completions
# https://zsh.sourceforge.io/Doc/Release/Completion-System.html#Control-Functions
zstyle ':completion:*' completer _extensions _complete _approximate

zstyle ':completion:*:*:*:*:corrections' format '%F{yellow}!- %d (errors: %e) -!%f'
zstyle ':completion:*:*:*:*:descriptions' format '%F{blue}-- %d --%f'
zstyle ':completion:*:*:*:*:messages' format ' %F{purple} -- %d --%f'
zstyle ':completion:*:*:*:*:warnings' format ' %F{red}-- no matches found --%f'

# Group completion entries
zstyle ':completion:*' group-name ''

# Style completion entries
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Shift-tab for selecting previous completion
bindkey -M menuselect "${terminfo[kcbt]}" reverse-menu-complete

# Inspired by https://thevaluable.dev/zsh-completion-guide-examples/
# https://wiki.archlinux.org/title/Zsh
