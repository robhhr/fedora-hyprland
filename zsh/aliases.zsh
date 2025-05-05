# actions
alias zshreload='source ~/.zshrc'
alias grep='grep --color=auto'
alias less='less -R'
alias e='exit'

# paths
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias temp='~/Documents/temp'
alias dev='~/dev'
alias htdocs='~/../../Applications/MAMP/htdocs'
alias wpl='~/Local\ Sites'
alias config='~/.config'
alias hconf='~/.config/hypr/'

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

# misc
alias t='tmux'
alias m='mullvad'
alias weather="curl v2.wttr.in/${1:-Vancouver} --silent | less -S -R -#3"

