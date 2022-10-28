alias ls='lsd -lah'                           # colorize `ls` output
alias zshreload='source ~/.zshrc'             # reload ZSH
alias shtop='sudo htop'                       # run `htop` with root rights
alias grep='grep --color=auto'                # colorize `grep` output
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias less='less -R'
alias htdocs='~/../../Applications/MAMP/htdocs'
alias temp='~/Documents/temp'

alias g='git'
alias gA='git add -A'
alias gU='git add -u'
alias gc='git commit -m'
alias gp='git push'
alias gcb='git checkout -b'
alias gs='git status'
alias gsw='git switch'
alias grb='git branch | grep -v "main" | xargs git branch -D'

alias n='nvim'
alias nconfig='nvim ~/.config/nvim/lua/'
alias nzsh='nvim ~/.zshrc'
alias aliases='nvim ~/.zsh/aliases.zsh'
alias e='exit'

alias rm='rm -i'                              # confirm removal
alias cp='cp -i'                              # confirm copy
alias mv='mv -i'                              # confirm move
alias cal='gcal --starting-day=1'             # print simple calendar for current month
alias weather='curl v2.wttr.in'               # print weather for current location (https://github.com/chubin/wttr.in)

