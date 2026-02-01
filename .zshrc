# ZSH Configuration

# Path to oh-my-zsh installation 
# install: sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)")
export ZSH="$HOME/.oh-my-zsh"

# Theme 
ZSH_THEME="robbyrussell"

# Environment Variables
export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"

# History Configuration
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt APPEND_HISTORY

# Path Configuration
export PATH="/Library/TeX/texbin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

# Aliases - File Management
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias yy='yazi'

# Aliases - Editor
alias v='nvim'

# Aliases - Git
alias g='git'
alias gs='git status'
alias ga='git add'
alias gaa='git add --all'
alias gc='git commit -v'
alias gcm='git commit -m'
alias gp='git push'
alias gpl='git pull'
alias gd='git diff'
alias gdc='git diff --cached'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gb='git branch'
alias gba='git branch -a'
alias gl='git log --oneline --decorate --graph'
alias gla='git log --oneline --decorate --graph --all'
alias gst='git stash'
alias gstp='git stash pop'

# Aliases - Python
alias venv='python3 -m venv'
alias activate='source venv/bin/activate'

# Aliases - System
alias cls='clear'
alias h='history'
alias grep='grep --color=auto'
alias mkdir='mkdir -pv'
alias ports='lsof -i -P -n | grep LISTEN'
alias update='brew update && brew upgrade'

# Aliases - Navigation
alias dev='cd ~/Code'
alias dl='cd ~/Downloads'
alias dt='cd ~/Desktop'
alias docs='cd ~/Documents'

# Aliases - Quick edits
alias zshrc='nvim ~/.zshrc'
alias vimrc='nvim ~/.config/nvim/init.lua'
alias reload='source ~/.zshrc'

# Functions - Utilities
mkcd() {
  mkdir -p "$1" && cd "$1"
}

extract() {
  if [ -f "$1" ]; then
    case "$1" in
      *.tar.bz2)   tar xjf "$1"     ;;
      *.tar.gz)    tar xzf "$1"     ;;
      *.bz2)       bunzip2 "$1"     ;;
      *.rar)       unrar x "$1"     ;;
      *.gz)        gunzip "$1"      ;;
      *.tar)       tar xf "$1"      ;;
      *.tbz2)      tar xjf "$1"     ;;
      *.tgz)       tar xzf "$1"     ;;
      *.zip)       unzip "$1"       ;;
      *.Z)         uncompress "$1"  ;;
      *.7z)        7z x "$1"        ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

gclone() {
  git clone "$1" && cd "$(basename "$1" .git)"
}

findfile() {
  find . -name "*$1*"
}

serve() {
  local port="${1:-8000}"
  python3 -m http.server "$port"
}

# Functions - Git
gacp() {
  git add --all
  git commit -m "$1"
  git push
}

gundo() {
  git reset --soft HEAD~1
}

# Functions - Directory navigation
cdls() {
  cd "$1" && ls
}

# Language specific settings
export PYTHONDONTWRITEBYTECODE=1
export PYTHONUNBUFFERED=1

# Node.js settings
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"


# Go settings
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# Completion settings
autoload -Uz compinit
compinit

# Case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

# Colored completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Key bindings
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
bindkey '^[[3~' delete-char

# Prompt customization
autoload -Uz vcs_info
precmd() { vcs_info }
zstyle ':vcs_info:git:*' formats ' (%b)'
setopt PROMPT_SUBST
PROMPT='%F{blue}%~%f%F{red}${vcs_info_msg_0_}%f %F{green}❯%f '

# Performance
if [ -s "$HOME/.nvm/nvm.sh" ]; then
  export NVM_DIR="$HOME/.nvm"
  alias nvm='unalias nvm; [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"; nvm $@'
fi

# Plugins
 plugins=(
   git
   zsh-autosuggestions
   zsh-syntax-highlighting
   docker
   kubectl
)
source $ZSH/oh-my-zsh.sh


# Welcome message
echo "Welcome $(whoami)"
