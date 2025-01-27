export ZSH_DISABLE_COMPFIX="true"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

if [ -z "$INTELLIJ_ENVIRONMENT_READER" ]; then
  export DISABLE_AUTO_UPDATE=true
fi
export FZF_BASE=/opt/homebrew/var/homebrew/linked/fzf

# The following lines were added by compinstall
zstyle ':completion:*' completer _expand _complete _ignored _correct _approximate
zstyle ':completion:*' max-errors 2
zstyle :compinstall filename "~/.zshrc"

autoload -Uz compinit
compinit
# End of lines added by compinstall

# Load Antigen
source "/Users/.dot_files/antigen/antigen.zsh"

# Load Antigen configurations
antigen init ~/.antigenrc

# Options to fzf command
export FZF_COMPLETION_OPTS='--border --info=inline'

# Use fd (https://github.com/sharkdp/fd) instead of the default find
# command for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
_fzf_compgen_path() {
  fd --hidden --follow --exclude ".git" . "$1"
}

# Use fd to generate the list for directory completion
_fzf_compgen_dir() {
  fd --type d --hidden --follow --exclude ".git" . "$1"
}

# (EXPERIMENTAL) Advanced customization of fzf options via _fzf_comprun function
# - The first argument to the function is the name of the command.
# - You should make sure to pass the rest of the arguments to fzf.
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    alias)        $command | fzf "$@" ;;
    cd)           fzf "$@" --preview 'tree -C {} | head -200' ;;
# FIXME
# Not echo'ing env vars as hoped    
#    echo)         fzf "$@" --preview 'echo ${}' ;;
    echo|export|unset) fzf "$@" --preview "eval 'echo \$'{}" ;;
    #ls)           fzf "$@" --preview 'if [[ -f {} ]]; then bat --color=always --style=numbers --line-range=:500 {};else tree -C {} | head -200; fi' ;;
    ls|vim)       fzf "$@" --preview 'if [[ -f {} ]]; then bat --color=always --style=numbers --line-range=:500 {};else tree -C {} | head -200; fi' --bind shift-up:preview-page-up,shift-down:preview-page-down ;;
    ssh)          fzf "$@" --preview 'dig {}' ;;
    *)            fzf "$@" ;;
  esac
}


# If you come from bash you might have to change your $PATH.
export PATH=/opt/homebrew/bin:/usr/local/bin:/opt/homebrew/opt:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/.dot_files/.oh-my-zsh

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
#ZSH_THEME="agnoster"
ZSH_THEME="powerlevel10k/powerlevel10k"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(autojump aws brew common-aliases dircycle docker fzf history git gitignore jsontools magic-enter man macos npm sudo terraform zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=60'
export ZSH_HIGHLIGHT_STYLES[default]='fg=cyan,bold' #base1
export ZSH_HIGHLIGHT_STYLES[alias]='fg=blue'
export ZSH_HIGHLIGHT_STYLES[builtin]='fg=yellow'
export ZSH_HIGHLIGHT_STYLES[function]='fg=blue'
export ZSH_HIGHLIGHT_STYLES[command]='fg=blue'
export ZSH_HIGHLIGHT_STYLES[precommand]='fg=blue'
export ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=green,bold' #base01
export ZSH_HIGHLIGHT_STYLES[path]='fg=cyan'
export ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=blue,bold' #base0
export ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=blue,bold' #base0
export ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=red,bold' #orange

source ~/.bash_profile
source ~/.zshrc_local
source $ZSH/oh-my-zsh.sh

# User configuration

# brew
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# NVM
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

# VIM mode
bindkey -v
bindkey "^R" history-incremental-search-backward

# Search history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Fix git HEAD^ issue
setopt NO_NOMATCH

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
 export EDITOR='vim'
else
 export EDITOR='mvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh

export PYENV_ROOT=~/.pyenv
export PATH=$PYENV_ROOT/shims:$PATH
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
alias pv='python --version'

complete -o nospace -C /opt/homebrew/bin/terraform terraform
alias tff='terraform force-unlock -force'

# AWS
export AWS_DEFAULT_REGION=us-east-1
export AWS_PAGER="cat"
alias ecrl='aws ecr describe-images --repository-name ${SERVICE_NAME}-$(aws sts get-caller-identity | jq -r .Account) --query "sort_by(imageDetails,& imagePushedAt)[-1].imageTags[0]" | jq -r'
complete -C '/usr/local/bin/aws_completer' aws

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# HSTR configuration - add this to ~/.zshrc
#alias hh=hstr                    # hh to be alias for hstr
#setopt histignorespace           # skip cmds w/ leading space from history
#export HSTR_CONFIG=hicolor       # get more colors
#bindkey "^B^H" beginning-of-line
#bindkey -s "\C-r" "\C-b\c-h hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# zbrowse
#source ~/.antigen/bundles/zdharma-continuum/zbrowse/zbrowse.plugin.zsh
#source ~/.antigen/bundles/zdharma-continuum/zui/zui.plugin.zsh

# ssh-agent
zstyle :omz:plugins:ssh-agent identities github_rsa

# fzf-tab
# disable sort when completing `git checkout`
enable-fzf-tab
zstyle ':completion:*:git-checkout:*' sort false
# set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'
# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
# preview directory's content with exa when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
# switch group using `,` and `.`
zstyle ':fzf-tab:*' switch-group ',' '.'
zstyle ':fzf-tab:*' continuous-trigger '/'

# FIXME
# Doesn't seem to work?
# https://github.com/nhooyr/dotfiles/blob/92623b7a3e9fa421d191f6c2bb77de4ce60aa367/zsh/fzf.zsh#L48-L61
#
# rebind to execute fzf history selection on enter
fzf_history() {
  local selected
  IFS=$'\n' selected=($(fc -lnr 1 | fzf --expect=ctrl-v --no-sort --height=40% --query="$BUFFER"))
  if [[ "$selected" ]]; then
    LBUFFER="$selected"
    if [[ ${#selected[@]} -eq 2 ]]; then
      LBUFFER="${selected[2]}"
      zle accept-line
    fi
  fi
  zle reset-prompt
}
zle -N fzf-history fzf_history
bindkey "^R" fzf-history

# alias for preview fzf
alias pf="fzf --preview='less {}' --bind shift-up:preview-page-up,shift-down:preview-page-down"

# enable jq
source ~/.antigen/bundles/reegnz/jq-zsh-plugin/jq.plugin.zsh

export GODEBUG=asyncpreemptoff=1

# added by travis gem
[ ! -s $HOME/.travis/travis.sh ] || source $HOME/.travis/travis.sh

###-begin-projen-completions-###
#
# yargs command completion script
#
# Installation: projen completion >> ~/.zshrc
#    or projen completion >> ~/.zsh_profile on OSX.
#
_projen_yargs_completions()
{
  local reply
  local si=$IFS
  IFS=$'
' reply=($(COMP_CWORD="$((CURRENT-1))" COMP_LINE="$BUFFER" COMP_POINT="$CURSOR" projen --get-yargs-completions "${words[@]}"))
  IFS=$si
  _describe 'values' reply
}
compdef _projen_yargs_completions projen
###-end-projen-completions-###

# 1Password
export OP_BIOMETRIC_UNLOCK_ENABLED=true

#export DOCKER_HOST="unix://${HOME}/.colima/default/docker.sock"

# tfenv
export TFENV_ARCH=arm64 

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
