# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

####################################################### HERE GOES MY PERSONAL CONFIG #########################################
# Used for identify if in a screen session
if [ ! "$STY" == "" ]; then
    PS1="[$STY]$PS1"
fi
# Used for identify if in a pbuilder env
if [ ! "$ANPBUILDER" == "" ]; then
    PS1="[PBUILDER]$PS1"
else
    if [ `hostname` == "build02" ]; then
        export TERM=screen-256color
        # env for local apps if not in pbuilder
        LINCOLNAPPDIR=$HOME/Applications
        export PATH=$LINCOLNAPPDIR/python2.7/bin:$LINCOLNAPPDIR/vim7.4/bin:$LINCOLNAPPDIR/binutils/bin:$LINCOLNAPPDIR/scripts:$LINCOLNAPPDIR/cmatrix/bin:$LINCOLNAPPDIR/gcc-4.8.5/bin:$LINCOLNAPPDIR/cmake-3.6.0/bin:$LINCOLNAPPDIR/libevent/bin:$LINCOLNAPPDIR/ncurses/bin:$LINCOLNAPPDIR/tmux-2.2/bin:$LINCOLNAPPDIR/faup/bin:$LINCOLNAPPDIR/valgrind-3.12/bin:$LINCOLNAPPDIR/squid/bin:$LINCOLNAPPDIR/curl/bin:$LINCOLNAPPDIR/wget/bin:$LINCOLNAPPDIR/flex/bin:$LINCOLNAPPDIR/bison/bin:$LINCOLNAPPDIR/cscope/bin:$PATH
        export LD_LIBRARY_PATH=$LINCOLNAPPDIR/python2.7/lib:$LINCOLNAPPDIR/libevent/lib:$LINCOLNAPPDIR/gmp/lib:$LINCOLNAPPDIR/mpfr/lib:$LINCOLNAPPDIR/mpc/lib:$LINCOLNAPPDIR/libelf/lib:$LINCOLNAPPDIR/gcc-4.8.5/lib64:$LINCOLNAPPDIR/libevent/lib:$LINCOLNAPPDIR/ncurses/lib:$LINCOLNAPPDIR/faup/lib:$LINCOLNAPPDIR/valgrind-3.12/lib/valgrind:$LINCOLNAPPDIR/squid/lib:$LINCOLNAPPDIR/readline/lib:$LINCOLNAPPDIR/flex/lib:$LINCOLNAPPDIR/bison/lib
        export LD_RUN_PATH=$LINCOLNAPPDIR/python2.7/lib:$LINCOLNAPPDIR/gcc-4.8.5/lib64:$LINCOLNAPPDIR/faup/lib:$LINCOLNAPPDIR/valgrind-3.12/lib/valgrind:$LINCOLNAPPDIR/readline/lib
    fi
fi 
####################################################### HERE ENDS MY PERSONAL CONFIG #########################################

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi


# Alias
alias asb-gnu='/tools/bin/asb-gnu'
alias asbb='asb-gnu compile-x86'
alias asbbo='asb-gnu compile-x86 OPTIMIZED_BUILD=yes'
alias asbi='asb-gnu install-x86'
alias asbg='asb-gnu compile-gtests'
alias asbc='asb-gnu clean'
alias gows='cd /data/lincoln_xiong/'
alias gitpatch='git diff --no-ext-diff --no-prefix'
alias mtag='make_ctags.py'

# env for pcrfsim
export ACW_PAYMENTTYPE=PO
export CPSROAMZONE=On-Net
export CPSROAMZONEUPDATE=On-Net
unset ACR_POLICY1
#export ACW_POLICY1=NOABR

# env for build machine
export EDITOR=vi

