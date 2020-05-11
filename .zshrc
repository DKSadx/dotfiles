# ---------------------------------------------- #
# --------------- Aliases ---------------------- #
# ---------------------------------------------- #
# Neovim
alias nv='nvim'
alias vim='nvim'
# Git diff in neovim
alias gdif='nvim -c "Gdiff"'
# Untar tar files
alias untar='tar -zxvf'
alias c='clear'
# List all open ports
alias ports='lsof -i'
# Start named tmux session
alias tmuxn='tmux new -s'

#--- Kubernetes ---
# K9s
alias k='k9s'
# Cd to dotfiles git directory
alias cdL='cd ~/Documents/backup/Linux-dotfiles'

# ---------------------------------------------- #
# --------------- Oh-my-zsh stuff -------------- #
# ---------------------------------------------- #

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Theme
#ZSH_THEME="theunraveler"
ZSH_THEME="robbyrussell"
#PROMPT='[%m@%1d] '
PS1=$'%{\e[0;32m%}[%1d] >%{\e[0m%} '
#PS1=$'%{\e%}[0;32m[%m@%1d] %{\e%}[0m'
#%{...%}

# Disables auto updates
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS=true

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.


# ---------------------------------------------- #
# --------------- Configs ---------------------- #
# ---------------------------------------------- #

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
bindkey '^R' history-incremental-search-backward
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
#bindkey -v '^?' backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
# echo -ne '\e[5 q' # Use beam shape cursor on startup.
# preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.

# Sets shell default editor to neovim
EDITOR=/usr/bin/nvim
VISUAL=/usr/bin/nvim

# Edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line


# ---------------------------------------------- #
# --------------- Plugins ---------------------- #
# ---------------------------------------------- #
plugins=(git vi-mode extract)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
