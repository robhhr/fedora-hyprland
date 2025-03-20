export ZSH="$HOME/.oh-my-zsh"
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/local/sbin:/usr/sbin:$PATH"
export PGDATA="$HOME/Documents/postgres/"

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

source $XDG_CONFIG_HOME/zsh/env.zsh

# plugins
plugins=(git zsh-autosuggestions shrink-path nvm)

source $ZSH/oh-my-zsh.sh

source $XDG_CONFIG_HOME/zsh/aliases.zsh

eval "$(starship init zsh)"

