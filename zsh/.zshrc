export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"

# plugins
plugins=(git zsh-autosuggestions shrink-path nvm)

source $ZSH/oh-my-zsh.sh

source $XDG_CONFIG_HOME/zsh/aliases.zsh

eval "$(starship init zsh)"

