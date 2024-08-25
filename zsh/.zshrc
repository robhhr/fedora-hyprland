export ZSH="/Users/robhhr/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# plugins
plugins=(git zsh-autosuggestions shrink-path nvm)

# aliases
source /Users/robhhr/.config/zsh/aliases.zsh

# [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
# source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
# eval "$(rbenv init -)"

eval "$(starship init zsh)"

