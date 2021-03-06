# ls Aliases
alias ll='ls -lh'
alias la='ls -a'
alias lla='ll -a'
alias lld='lla | grep "^d"'
alias llf='lla | grep -v "^d"'

# cd Aliases
alias -- -='cd -'
alias cd..='cd ..'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias .......='cd ../../../../../..'
alias ........='cd ../../../../../../..'
alias .........='cd ../../../../../../../..'
alias ..........='cd ../../../../../../../../..'

# dig Aliases
alias digs='dig +short'

# Color Aliases
alias grep='grep --color=auto'
alias tmux="TERM=screen-256color-bce tmux"

# Git Aliases
alias gs='git status'
alias gp='git pull'

# Ruby Aliases
#alias be='bundle exec'

# Webpack Aliases
alias wp='webpack --progress --colors'
alias ww='wp --watch'

# Homebrew Aliases
alias brewup='brew update && brew upgrade'
