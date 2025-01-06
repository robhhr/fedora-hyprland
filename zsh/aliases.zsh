# actions
# alias ls='lsd -lah'
alias zshreload='source ~/.zshrc'
alias grep='grep --color=auto'
alias less='less -R'
alias e='exit'

# paths
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias temp='~/Documents/temp'
alias htdocs='~/../../Applications/MAMP/htdocs'
alias wpl='~/Local\ Sites'
alias config='~/.config'

# git
alias g='git'
alias gA='git add -A'
alias gU='git add -u'
alias gc='git commit -m'
alias gp='git push'
alias gpo='git pull origin'
alias gcb='git checkout -b'
alias gs='git status'
alias gsw='git switch'

# nvim
alias n='nvim'
alias nconf='nvim ~/.config/nvim/'
alias nzsh='nvim ~/.zshrc'
alias aliases='nvim ~/.zsh/aliases.zsh'

# tmux
alias t='tmux'
alias tks='tmux kill-server'
alias tx='tmuxinator'

# misc
alias weather="curl v2.wttr.in/${1:-Vancouver} --silent | less -S -R -#3"

