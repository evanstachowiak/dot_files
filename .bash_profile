#!/usr/bin/env bash

# Enable color output
export CLICOLOR=1
export color_prompt=yes

# Set default applications
export EDITOR=vim
export VISUAL=vim
if hash vimpager 2>/dev/null; then
  export PAGER=vimpager
else
  export PAGER=less
fi

# Set shell hotkeys to vim
set -o vi

# Finds the dereferenced directory of the current script
get_script_dir () {
  local SOURCE="${BASH_SOURCE[0]}"
  local DIR="$( dirname "$SOURCE" )"

  while [ -h "$SOURCE" ]; do
    SOURCE="$(readlink "$SOURCE")"
    [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE"
    DIR="$( cd -P "$( dirname "$SOURCE"  )" && pwd )"
  done

  local RETVAL="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  if [[ $# = 0 ]]; then
    SCRIPTDIR=$RETVAL
  else
    eval "$1='$RETVAL'"
  fi
}

get_script_dir DOTFILESDIR

# Define functions
#for function in $DOTFILESDIR/bash/*; do
  #source $function;
#done

# Add the dot_files bin to PATH
export PATH=$DOTFILESDIR/bin:$PATH

# Setup prompt
Color_Prefix='\e[0;'  # Required prefix for defining colors
Color_Suffix='m'     # Required suffix for defining colors
Color_Off="\e[m" # Text Reset
Black="${Color_Prefix}30${Color_Suffix}"   # Black
Red="${Color_Prefix}31${Color_Suffix}"     # Red
Green="${Color_Prefix}32${Color_Suffix}"   # Green
Yellow="${Color_Prefix}33${Color_Suffix}"  # Yellow
Blue="${Color_Prefix}34${Color_Suffix}"    # Blue
Purple="${Color_Prefix}35${Color_Suffix}"  # Purple
Cyan="${Color_Prefix}36${Color_Suffix}"    # Cyan
White="${Color_Prefix}37${Color_Suffix}"   # White

#export GIT_PS1_SHOWDIRTYSTATE='auto'
#export GIT_PS1_SHOWUNTRACKEDFILES='auto'
#export GIT_PS1_SHOWUPSTREAM='auto'
#. /usr/local/etc/bash_completion.d/git-completion.bash
#source /usr/local/etc/bash_completion.d/git-prompt.sh

#export PS1="\u@ \w\$(__git_ps1 ' (%s)') \! $ "

# Git aliases
alias gb='git branch '
alias gbd='git branch -d '
alias gcb='git checkout -b '
alias gcane='git commit --amend --no-edit --no-verify'
alias gsha='git rev-parse --short HEAD'
alias gl='tig'
alias glr='git log --reverse -10'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias gco='git checkout '
alias gcom='git checkout master'
alias ga='git add'
alias gp='git pull --rebase'
alias gpr='git pull --rebase'
alias grpo='git remote prune origin'
alias gpsh='git push --follow-tags'
alias gpshf='git push --force'
alias gst='git stash'
alias gstp='git stash pop'

# Terraform aliases
alias st='shift-ops terraform'
alias sta='shift-ops terraform apply'
alias tp='terraform plan'
alias ta='terraform apply'
alias taa='terraform apply -auto-approve'
alias tfu='terraform plan 2>&1 | awk '\''/ID/ {print $3}'\'' | xargs -I {} terraform force-unlock -force {}'

# IP
alias ip='curl -s ifconfig.co'
# Include local settings
if [ -r ~/.bash_local ]; then
  source ~/.bash_local
fi

# autocomplete
#complete -C aws_completer aws

## JIRA
#complete -F get_jira_targets jira
#function get_jira_targets()
#{
    #if [ -z $2 ] ; then
        #COMPREPLY=(`jira help -c`)
    #else
        #COMPREPLY=(`jira help -c $2`)
    #fi
#}

## SVN
#alias sc="svn commit -m'"
#alias ss='svn status'

# git
alias git_rm_deleted="git status | awk '/deleted/ {system(\"git rm \" \$3)}'"

# Java
export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home

# Proxy
#no_proxy() {
  #unset http_proxy
  #unset https_proxy
  #unset ftp_proxy
#}

# RVM
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"


# Ruby
alias be='bundle exec'
alias vim='rvm system do /usr/local/bin/vim $@'

# Python
export PYENV_ROOT=~/.pyenv
export PATH=$PYENV_ROOT/shims:$PATH
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
alias pv='python --version'

# Docker
#eval $(docker-machine env docker-machine)

alias fix_virtualbox='sudo chown root:admin /Applications && sudo chmod o-w /Applications'

# Casper Spec Helper
rspecdb() {
  rake db:drop db:setup RAILS_ENV=test
  rspec $@
}

