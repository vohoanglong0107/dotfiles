# To customize prompt, run `p10k configure` or edit ~/.zsh/p10k/p10k.zsh.
if zmodload zsh/terminfo && (( terminfo[colors] >= 256 )); then
  source ~/.zsh/p10k/p10k.zsh
else
  source ~/.zsh/p10k/p10k-compat.zsh
fi
