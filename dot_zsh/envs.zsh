source ~/.zsh/envs/bat.zsh
source ~/.zsh/envs/go.zsh
source ~/.zsh/envs/oh-my-zsh.zsh
source ~/.zsh/envs/p10k.zsh
source ~/.zsh/envs/rust.zsh
source ~/.zsh/envs/ssh.zsh

# remove duplicate entry from $PATH. $PATH is string while $path is array
typeset -aU path
