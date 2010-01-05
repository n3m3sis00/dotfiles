# Bashrc --- Karl Yngve Lerv�g
# -----------------------------------------------------------------------------
#
if [ ! "$already_sourced" ]; then
  already_sourced=1
  #
  # We only do the following part once
  #
#{{{ Set environmental variables

# Set some environmental variables
export HOSTNAME="`hostname -s`"
export EDITOR="vim"
export XEDITOR="vim +%l %f"
export OPSYS=$(uname)
export HISTSIZE=2000
export HISTFILESIZE=2000
export HGENCODING="latin-1"
export NTNUSRV="login.stud.ntnu.no"
export PATH=$PATH:$HOME/scripts/bin
export RUBYLIB=$RUBYLIB:$HOME/scripts/lib
export BIBINPUTS="~/.references.bib"

# Default file permissions
umask 022

#}}}
#{{{ Define some aliases
alias rm="rm -i"
alias mv="mv -i"
alias cp="cp -i"
alias du="du -c"
alias grep="grep -i"
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -oh'
alias dir='ll'
alias dato='date +"Uke %V, %A %d. %B, %Y -- %T"'
alias mplayer='~/.MPlayer/MPlayer-1.0rc1/mplayer'
alias ..='cd ..'
alias ...='cd ../..'
alias cd..='cd ..'
alias e2n="ssh $NTNUSRV e2n"
alias n2e="ssh $NTNUSRV n2e"
alias vim="gvim"
[ ! "`which xpdf 2> /dev/null`" ] && [ "`which kpdf 2> /dev/null`" ] \
  && alias xpdf='kpdf'

#}}}
#{{{ Load system settings

sysfile=~/system_files/bashrc.sh
[ -f $sysfile ] && . $sysfile

#}}}
#{{{ Welcome message
if [ -t 0 ] && [ -t 1 ]; then
  if [ ! "$tasks_written" ]; then
    echo "Velkomen til $HOSTNAME! "
    echo "---------------------------------------------------------------------"
    echo
  fi

  # Set a good command prompt
  export PS1='\[\e[1m\]\u@\h:\[\e[34m\]\[\e[1m\]\w\[\e[0m\]> '

  # Remove CTRL-s and CTRL-q possibility
  stty stop undef
  stty start undef
fi
#}}}
fi
#
# -----------------------------------------------------------------------------
# vim: set foldmethod=marker ff=unix:
