# zshrc --- Karl Yngve Lervåg
# -----------------------------------------------------------------------------
# Created 2011-06-19
#
# Check if already sourced
if [ ! "$already_sourced" ]; then
  already_sourced=1
else
  return
fi
#{{{1 Set environmental variables
# General
export HOSTNAME="`hostname -s`"
export EDITOR="vim"
export XEDITOR="vim +%l %f"
export OPSYS=$(uname)
export HISTSIZE=20000
export SAVEHIST=10000
export HISTFILE=".zsh_history"
export PATH=$PATH:$HOME/scripts/bin
export PAGER='less'

# Other
export HGENCODING="latin-1"
export NTNUSRV="login.stud.ntnu.no"
export RUBYLIB=$RUBYLIB:$HOME/scripts/lib
export BIBINPUTS=.:~/:
export TEXMFHOME=$HOME/.texmf
export PETSC_DIR=/home/petsc/petsc-current
eval `dircolors -b`

#{{{1 Define aliases
# General aliases
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias du="du -c"
alias grep="grep -i"
alias s='ls'
alias l='ls'
alias ls='ls -X --color=auto --group-directories-first'
alias ll='ls -ogh'
alias lsa='ls -A'
alias dato='date +"Uke %V, %A %d. %B, %Y -- %T"'
alias ..='cd ..'
alias ...='cd ...'
alias cd..='cd ..'
alias e2n="ssh $NTNUSRV e2n"
alias n2e="ssh $NTNUSRV n2e"
[ ! "`which xpdf 2> /dev/null`" ] && [ "`which kpdf 2> /dev/null`" ] \
  && alias xpdf='kpdf'
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] \
  && echo terminal || echo error)" "$(history|tail -n1| \
  sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Extension stuff
alias -s gz='tar -xzvf'
alias -s tgz='tar -xzvf'
alias -s bz2='tar -xjvf'
alias -s txt=gvim
alias -s tex=gvim
alias -s pdf=evince
alias -s png=eog
alias -s jpg=eog

# Global aliases
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'

# Utility functions
evince() { command evince ${*:-*.pdf(om[1])} }
okular() { command okular ${*:-*.pdf(om[1])} }

#{{{1 Options
umask 022           # Default file permissions
ulimit -s unlimited # Set stack size limit
watch=( notme )     # Notify all logins or logouts (that are not me)

# Turn on/off some zsh options
unsetopt bgnice
setopt nohup \
       print_exit_value
setopt interactive_comments
setopt clobber
setopt extended_history \
       inc_append_history \
       bang_hist \
       hist_verify \
       hist_expire_dups_first \
       hist_ignore_dups \
       hist_reduce_blanks \
       share_history
setopt correct_all
setopt notify
setopt complete_aliases \
       rec_exact
setopt extended_glob
setopt longlistjobs
setopt auto_cd \
       auto_list
setopt auto_pushd \
       pushd_ignore_dups \
       pushd_to_home

# Autoload zsh modules when they are referenced
zmodload zsh/stat
zmodload zsh/mathfunc

# Add plugins and stuff
autoload -U zmv
autoload -U zsh/terminfo
autoload -U compinit
autoload -U colors
compinit
colors

#{{{1 Autocompletion styles
#{{{2 Global settings
# Turn on cache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.zsh/cache

# Set more verbose output
zstyle ':completion:*' verbose yes

# Fuzzy matching of completions for when you mistype them
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle -e ':completion:*:approximate:*' max-errors \
          'reply=($((($#PREFIX+$#SUFFIX)/2)) numeric)'

# First simple completion, then case-insensitive completion
zstyle ':completion:*' matcher-list '' '+m:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
#zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Ignore completion functions for commands I don't have
zstyle ':completion:*:functions' ignored-patterns '_*'

# Remove trailing slash (usefull in ln)
zstyle ':completion:*' squeeze-slashes true

# Have all different types of matches displayed separately
zstyle ':completion:*' group-name ''

# Set color specifications
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# Set list prompt if completion list fills more than one screen
zstyle ':completion:*' list-prompt \
       '%SAt %p, %l: Hit TAB for more or character to insert.%s'

#{{{2 Unprocessed
zstyle ':completion:*:expand:*' tag-order all-expansions
zstyle ':completion:*:descriptions' format '%B%d%b'
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format 'No matches for: %d'
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*:*:-subscript-:*' tag-order indexes parameters
zstyle ':completion:*:processes-names' command 'ps axho command'

#{{{2 Program specific settings
# Have words sorted by time for okular and evince
zstyle ':completion:*:*:okular:*' meny yes select
zstyle ':completion:*:*:okular:*' file-sort time
zstyle ':completion:*:*:evince:*' meny yes select
zstyle ':completion:*:*:evince:*' file-sort time

# Options for kill
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:*:kill:*' meny yes select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:*:kill:*:processes' \
       command 'ps --forest -u lervag -o pid,user,cmd'

# cd wil never select parent directory
zstyle ':completion:*:cd:*' ignore-parents parent pwd

#{{{1 Set command prompt
ps_blue="%{$terminfo[bold]$fg[blue]%}"
ps_green="%{$terminfo[bold]$fg[green]%}"
ps_red="%{$terminfo[bold]$fg[red]%}"
ps_white="%{$terminfo[bold]$fg[white]%}"
ps_reset="%{$terminfo[sgr0]%}"
export PS1="$ps_blue%n$ps_white@$ps_green%m$ps_reset:$ps_red%3~$ps_reset%(!.#.$) " 
#export RPS1="$PR_LIGHT_YELLOW(%D{%m-%d %H:%M})$PR_NO_COLOR"

#{{{1 Add some keybindings
bindkey -v
bindkey ' '    magic-space
bindkey "\C-R" history-incremental-pattern-search-backward
bindkey "\C-X" history-incremental-pattern-search-forward
bindkey "\E[Z" reverse-menu-complete
bindkey "^U"   backward-kill-line
bindkey "^F"   vi-forward-char
bindkey "^B"   vi-backward-char

#{{{1 Load system-specific settings
sysfile=~/system_files/bashrc.sh
[ -f $sysfile ] && source $sysfile

#{{{1 Modeline ----------------------------------------------------------------
# vim: set foldmethod=marker ff=unix: