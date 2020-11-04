# ---------------------------------------------- #
# --------------- Aliases ---------------------- #
# ---------------------------------------------- #
# Neovim
alias nv='nvim'
alias vim='nvim'
alias zrc='vim ~/.zshrc'
alias vrc='vim ~/.config/nvim/init.vim'
alias ll='ls -lGFh'
alias ls='ls -GF'
# Untar tar files
alias untar='tar -zxvf'
alias c='clear'
# List all open ports
alias ports='lsof -i'
# Mac clipboard
alias copy="tr -d '\n' | pbcopy"
# Generade UUID
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
# Python3
alias py="python3"
# Add yubikey
alias yk='ykadd'
alias less='less -r'

#--- Tmux ---
# Attach to tmux session
alias ta="tmux attach -t"
# Start named tmux session
alias tn='tmux new -s'
# List tmux sessions
alias tl='tmux ls'

#--- GIT ---
# Git diff in neovim
alias gdif='nvim -c "Gdiff"'
alias gitA='git add'
alias gitC='git commit -m'
alias gitP='git push origin'

#--- Kubernetes ---
# K9s
alias k='k9s'
# Kubectl
alias kc='kubectl'
# Descibe
alias kcd='kubectl descibe'
# Get
alias kcg='kubectl get'
# Minikube
alias mk='minikube'

# Opens man page as pdf
man2pdf () {
  man -t "$1" | open -fa "Preview"
}

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
plugins=(git osx vi-mode extract)

# Enables git plugin and places the branch name to the right side
autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%b'

#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
