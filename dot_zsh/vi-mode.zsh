# Configuration for zsh-vi-mode
function zvm_config() {
  ZVM_LINE_INIT_MODE=$ZVM_MODE_INSERT
  ZVM_INIT_MODE=sourcing
  ZVM_VI_HIGHLIGHT_BACKGROUND=black
  ZVM_VI_HIGHLIGHT_FOREGROUND=white
}

function yank_to_clipboard() {
  zvm_yank
  # CUTBUFFER is set by zvm_yank
  printf '\033]52;c;%s\007' "$(echo -n $CUTBUFFER | base64)"
  zvm_exit_visual_mode ${1:-true}
}

source ~/.zsh/external/zsh-vi-mode/zsh-vi-mode.zsh

zvm_define_widget yank_to_clipboard
zvm_bindkey visual ' y' yank_to_clipboard
