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
for function in $DOTFILESDIR/bash/*; do
  source $function;
done

# Add the dot_files bin to PATH
export PATH=$DOTFILESDIR/bin:$PATH

# Setup prompt
Color_Prefix='\[\033[0;3'  # Required prefix for defining colors
Color_Suffix='\]'     # Required suffix for defining colors
Color_Off="\[\033[0m\]" # Text Reset
Black="${Color_Prefix}0;30m${Color_Suffix}"   # Black
Red="${Color_Prefix}0;31m${Color_Suffix}"     # Red
Green="${Color_Prefix}0;32m${Color_Suffix}"   # Green
Yellow="${Color_Prefix}0;33m${Color_Suffix}"  # Yellow
Blue="${Color_Prefix}0;34m${Color_Suffix}"    # Blue
Purple="${Color_Prefix}0;35m${Color_Suffix}"  # Purple
Cyan="${Color_Prefix}0;36m${Color_Suffix}"    # Cyan
White="${Color_Prefix}0;37m${Color_Suffix}"   # White

export GIT_PS1_SHOWDIRTYSTATE='auto'
export GIT_PS1_SHOWUNTRACKEDFILES='auto'
export GIT_PS1_SHOWUPSTREAM='auto'
. /usr/local/etc/bash_completion.d/git-completion.bash
source /usr/local/etc/bash_completion.d/git-prompt.sh

export PS1="$Purple\u$Blue@\h $Green\w$Cyan\$(__git_ps1 ' (%s)') \! $Color_Off$ "

# Git aliases
alias gsha='git rev-parse --short HEAD'
alias gl='tig'
alias gs='git status'
alias gd='git diff'
alias gdc='git diff --cached'
alias gc='git commit'
alias ga='git add'
alias gp='git push'
alias gpr='git pull --rebase'
alias gst='git stash'
alias gstp='git stash pop'

# Include local settings
if [ -r ~/.bash_local ]; then
  source ~/.bash_local
fi

# AWS
export aws_regions=$(aws ec2 describe-regions | awk '{print $3}')
# autocomplete
complete -C aws_completer aws

# JIRA
complete -F get_jira_targets jira
function get_jira_targets()
{
    if [ -z $2 ] ; then
        COMPREPLY=(`jira help -c`)
    else
        COMPREPLY=(`jira help -c $2`)
    fi
}

# SVN
alias sc="svn commit -m'"
alias ss='svn status'

# git
alias git_rm_deleted="git status | awk '/deleted/ {system(\"git rm \" \$3)}'"

# Java
export JAVA_HOME=/System/Library/Java/JavaVirtualMachines/1.6.0.jdk/Contents/Home

# Proxy
no_proxy() {
  unset http_proxy
  unset https_proxy
  unset ftp_proxy
}

# Ruby
alias be='bundle exec'
alias vim='rvm system do /usr/local/bin/vim $@'

# Python
export PYENV_ROOT=~/.pyenv
export PATH=$PYENV_ROOT/shims:$PATH
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi

# Docker
eval $(docker-machine env docker)
