# vim:ft=zsh
if command -v nvim &> /dev/null ; then
  export EDITOR='nvim'
else
  export EDITOR='vi'
fi
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

# bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# https://github.com/sharkdp/bat/issues/652
export MANROFFOPT="-c"

# bemoji
export BEMOJI_PICKER_CMD="fuzzel --dmenu"

# fzf
if command -v fd &> /dev/null ; then
  export FZF_DEFAULT_COMMAND='fd --type f'
else
  export FZF_DEFAULT_COMMAND='find . -type f'
fi
export FZF_DEFAULT_OPTS=" \
--color=bg+:-1,bg:-1,spinner:#f5e0dc,hl:#f5e0dc \
--color=gutter:-1 \
--color=fg:#b4befe,header:#f38ba8,info:#cba6f7,pointer:#89dceb \
--color=marker:#f5e0dc,fg+:#89dceb,prompt:#cba6f7,hl+:#f5c2e7"

# fcitx5
export XMODIFIERS=@im=fcitx
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx

[ "$(tty)" = "/dev/tty1" ] && exec sway
