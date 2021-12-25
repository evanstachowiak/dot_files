# Setup fzf
# ---------
if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/opt/homebrew/var/homebrew/linked/fzf/shell/key-bindings.zsh"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/opt/homebrew/var/homebrew/linked/fzf/shell/key-bindings.zsh" 2> /dev/null

# Key bindings
# ------------
source "/opt/homebrew/var/homebrew/linked/fzf/shell/key-bindings.zsh"
