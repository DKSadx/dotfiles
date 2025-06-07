# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="agnoster"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS='%d.%m.%y'

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(
  git 
  vi-mode 
  zsh-histdb 
  zsh-syntax-highlighting
  zsh-autosuggestions
)

source $ZSH/oh-my-zsh.sh


# IMPORTANT: These configuration files must be below the 'source $ZSH/oh-my-zsh.sh' script!!!
# If it's not and if there is a conflict, the oh-my-zsh builtin aliases will replace the user aliases that were set before that line
# Example: ls alias won't apply if placed above

# ------------------
# User configuration
# ------------------

# Share history between terminals
setopt SHARE_HISTORY

# Disable clearing terminal with ctrl-l
bindkey -r "^L"

# Fixes opacity problem for the zsh-autosuggestions plugin
# This has weird behavior, to fix the opacity first enable it but it will break tmux.
# After the opacity is fixed, disable it again and both the plugin and tmux will work
export TERM="xterm-256color"

export HISTFILE="${HOME}/.zsh_history"
export HISTSIZE=100000
export SAVEHIST=100000

# Disable autoupdatees for brew
export HOMEBREW_NO_AUTO_UPDATE=1

# Disable autocd
unsetopt autocd

# Required for ARM M chips to work with conda
# export MKL_ENABLE_INSTRUCTIONS=SSE4_2

# Enhancements
# Read man pages with bat
export MANPAGER="sh -c 'col -bx | bat -l man -p'"
# Mouse scroll won't work in bat without this
export BAT_PAGER="less -RF"
# Don't show .git files with rg
export FZF_DEFAULT_COMMAND='rg --files --hidden -g "!.git" '
# Tags
export TAG_SEARCH_PROG="rg"
# Use podman with kind
export KIND_EXPERIMENTAL_PROVIDER="podman"

# Golang
export GOPATH="${HOME}/go"
export GOBIN="${HOME}/go/bin"
export GO111MODULE="on"
export PATH="${PATH}:${HOME}/local/bin:${HOME}/go/bin"

# ---------------------------------------------- #
# --------------- Aliases ---------------------- #
# ---------------------------------------------- #

# Histdb saves history into sqlite for easy querying: https://github.com/larkery/zsh-histdb
alias hist="histdb"
# Syntax highlighting pager mostly for diffs: https://github.com/dandavison/delta
alias diff="delta"
# GNU cp command instead of Mac's default one
# alias cp="gcp"
# nvim > vim
alias vim="nvim"
alias zrc="vim ${HOME}/.zshrc"
# Open zsh base configs
alias zrcw="vim ${HOME}/.work.zshrc"
# Open zsh work configs
alias wzrc="vim ${HOME}/.work.zshrc"
# Open nvim configs
alias vrc="cd ${HOME}/.config/nvim/lua/"
# No idea, forgot the use case
alias plt="pbpaste | pbcopy"
# # ls but with colors
# alias ll="ls -lGFh"
# alias ls="ls -GF"
# Prettier ls: https://github.com/eza-community/eza
alias ll="eza -lh"
alias ls="eza -gH"
# Untar tar files
alias untar="tar -zxvf"
alias c="clear"
# Mac clipboard
alias copy="tr -d '\n' | pbcopy"
# Copy current path
alias pc="pwd | tr -d '\n' | pbcopy"
# Generade UUID
alias uuid="uuidgen | tr '[:upper:]' '[:lower:]'"
# Display control characters liek [^
alias less="less -r"
# Open all snippets
alias snips="vim ${HOME}/.config/nvim/UltiSnips/*"
# Jupyter notebook but with go?
alias gojupyter="docker run -it -p 8888:8888 gopherdata/gophernotes"
# Box
alias cdbox="cd ${HOME}/Library/CloudStorage/Box-Box"

# --- Tmux ---
t() {
  # Tmux-sessionizer inspired by https://github.com/ThePrimeagen/tmux-sessionizer.
  # Uses https://github.com/skim-rs/skim
  declare -a tmux_sessionizer_paths=( 
  "${HOME}/dactyl-manuform-stuff"
  "${HOME}/projects"
  )

  TMUX_SESSIONIZER_HIDE_BASE_PATH="${HOME}" "${HOME}"/projects/min-dotfiles/tmux-sessionizer.sh ${tmux_sessionizer_paths[@]}
}

# Attach to tmux session
alias ta="tmux attach -t"
# Start named tmux session
alias tn="mux new -s"
# List tmux sessions
alias tl="tmux ls"

# --- GIT ---
# Git diff in neovim
alias gdif="nvim -c 'Gdiff'"
alias gita="git add"
alias gitc="git commit -m"
alias gitp="git push origin"
alias gitpl='git pull --rebase origin $(git rev-parse --abbrev-ref HEAD)'
alias gitco="git checkout"

# --- Containers and k8s ---
alias docker="podman"
alias kc="kubectl"
alias kgp="kubectl get pods"
alias kgn="kubectl get nods"
alias kgd="kubectl get deployment"
alias kdp="kubectl describe pod"
alias kdd="kubectl describe deployment"
alias kgs="kubectl get svc"
alias kds="kubectl describe svc"

# Encode string to base64
b64 () {
  echo "${1}" | tr -d '\n' | base64
}

# Decoded base64 to string
b64d () {
  echo "${1}" | base64 -d
}

# Opens man page as pdf
man2pdf () {
  man -t "${1}" | open -fa "Preview"
}

# Escape quotes
eqs () {
  echo "${1}" | sed 's/\"/\\\"/g' | tr -d '\n' | pbcopy 
}

# Un-Escape quotes
ueqs () {
  echo "${1}" | sed 's/\\\"/\"/g' | tr -d '\n' | pbcopy 
}

# Get cheat sheet for specific command; cs lsof
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



# PROMPT='[%m@%1d] '
# PS1=$'%{\e[0;32m%}[%1d] >%{\e[0m%} '
PROMPT=$'%{\e[0;32m%}[%1d] >%{\e[0m%} '
# precmd() {
#   PROMPT=$'%{\e[0;32m%}[%1d] >%{\e[0m%} '
#   PS1="$PROMPT"
# }

# Sets shell default editor to neovim
EDITOR="/opt/homebrew/bin/nvim"
VISUAL="/opt/homebrew/bin/nvim"
KUBE_EDITOR="/opt/homebrew/bin/nvim"
# Disables auto updates
DISABLE_AUTO_UPDATE="true"

# Basic auto/tab complete:
[[ -d /opt/homebrew/share/zsh/site-functions ]] && fpath+=(/opt/homebrew/share/zsh/site-functions)
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

# Change cursor shape for different vi modes
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
    # Initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    zle -K viins 
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Opens line in Vim with 'ctrl-e' and after edit places it into the terminal
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line

# Enables Git plugin and display the branch name on the right side
autoload -Uz compinit && compinit
autoload -Uz vcs_info
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
zstyle ':vcs_info:git:*' formats '%b'

# Kubectl auto completion
[[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)

# Node version manager: https://github.com/nvm-sh/nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# https://sdkman.io
#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="${PATH}:${HOME}/.rvm/bin"

[[ -f "${HOME}/.fzf.zsh" ]] && source ~/.fzf.zsh

# Load work related configs
[[ -f "${HOME}/.work.zshrc" ]] && source "${HOME}/.work.zshrc"

