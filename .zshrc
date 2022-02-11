export HISTFILE="$HOME/.zsh_history"
export HISTSIZE=10000000
export SAVEHIST=10000000
# Read man pages with bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# Mouse scroll won't work in bat without this
export BAT_PAGER="less -RF"
export GOPATH="$HOME/go"
export GOBIN="$HOME/go/bin"
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
export EDITOR="/opt/brew/bin/nvim"
export KUBE_EDITOR="/opt/brew/bin/nvim"
export GO111MODULE="on"
export TAG_SEARCH_PROG="rg"


# ---------------------------------------------- #
# --------------- Aliases ---------------------- #
# ---------------------------------------------- #
# GNU cp command instead of Mac's
alias cp='gcp'
# Neovim
alias nv='nvim'
alias vim='nvim'
alias wiki='nvim ~/Documents/wiki/index.md'
alias zrc='vim ~/.zshrc'
alias szrc='source ~/.zshrc'
alias vrc='vim ~/.config/nvim/init.vim'
alias ll='ls -lGFh'
alias l='ls -lGFh'
alias ls='ls -GF'

# Untar tar files
alias untar='tar -zxvf'
alias c='clear'
# List all open ports
alias ports='lsof -i'
# Mac clipboard
alias copy="tr -d '\n' | pbcopy"
alias pc="pwd | tr -d '\n' | pbcopy"
# Generade UUID
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
# Python3
alias py="python3"
alias less='less -r'
# Open all snippets
alias snips='vim ~/.config/nvim/UltiSnips/*'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias gojupyter='docker run -it -p 8888:8888 gopherdata/gophernotes'

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
alias gita='git add'
alias gitc='git commit -m'
alias gitp='git push origin'
alias gitco='git checkout'

#--- Movement ---
alias cdWiki='cd ~/Documents/wiki'
alias cdSar='cd ~/sar-stuff'
alias cdDesktop='cd ~/Desktop'

#--- Kubernetes ---
# K9s
#alias k='k9s'
alias k='k9s'
alias k9sc='vim "~/Library/Application Support/k9s/config.yml"'
alias kc='kubectl'
alias kgp='kubectl get pods'
alias kgn='kubectl get nods'
alias kgd='kubectl get deployment'
alias kdp='kubectl describe pod'
alias kdd='kubectl describe deployment'
alias kgs='kubectl get svc'
alias kds='kubectl describe svc'

# Opens man page as pdf
man2pdf () {
  man -t "$1" | open -fa "Preview"
}

cs () {
  local args="$(sed 's/ /\//g' <<< "${@}")"
  curl cht.sh/"$args"
}

# Swap file names
swap () {
  local file1="$1"
  local file2="$2"
  local tmpHash="$(sha256sum <<< "$(date)" | cut -d' ' -f1)"

  mv "$file1" "$tmpHash"
  mv "$file2" "$file1"
  mv "$tmpHash" "$file2"
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
# Fixes bug where you can't delete in insert mode
bindkey "^?" backward-delete-char
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

# Tag settings
if (( $+commands[tag] )); then
  export TAG_SEARCH_PROG=rg  # replace with rg for ripgrep
  tag() { command tag "$@"; source ${TAG_ALIAS_FILE:-/tmp/tag_aliases} 2>/dev/null }
  alias rg=tag  # replace with rg for ripgrep
fi

#source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
[ -f "~/.ghcup/env" ] && source "~/.ghcup/env" # ghcup-env

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin:$HOME/local/bin"
