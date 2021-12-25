export ZSH_DISABLE_COMPFIX="true"

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
export FZF_BASE=/opt/homebrew/var/homebrew/linked/fzf

# If you come from bash you might have to change your $PATH.
export PATH=/opt/homebrew/bin:/usr/local/bin:/opt/homebrew/opt:$PATH

# Path to your oh-my-zsh installation.
export ZSH=/Users/.dot_files/.oh-my-zsh

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

# Set name of the theme to load. Optionally, if you set this to "random"
# it'll load a random theme each time that oh-my-zsh is loaded.
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"
#ZSH_THEME="powerlevel9k/powerlevel9k"

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
plugins=(autojump aws dircycle docker fzf history git gitignore jsontools magic-enter man macos npm sudo terraform zsh-completions zsh-autosuggestions zsh-syntax-highlighting)

source ~/.bash_profile
source ~/.zshrc_local
source $ZSH/oh-my-zsh.sh

# User configuration

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

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

# AWS
export AWS_PAGER="cat"
complete -C '/usr/local/bin/aws_completer' aws

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# HSTR configuration - add this to ~/.zshrc
alias hh=hstr                    # hh to be alias for hstr
setopt histignorespace           # skip cmds w/ leading space from history
export HSTR_CONFIG=hicolor       # get more colors
bindkey "^B" beginning-of-line
bindkey -s "\C-r" "\C-b hstr -- \C-j"     # bind hstr to Ctrl-r (for Vi mode check doc)


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

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
