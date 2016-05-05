# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

{ ddate ; echo "" ; fortune ; } | cowsay | lolcat

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
    xterm-color|*-256color) color_prompt=yes;;
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







COLORWHEEL=( $( seq 27 -1 22 ) $( seq 28 33) $( seq 39 -1 34 ) $( seq 40 45 ) $( seq 51 -1 46 ) $( seq 82 87 ) $( seq 81 -1 76 ) $( seq 70 75 ) $( seq 69 -1 64 ) $( seq 58 63 ) $( seq 57 -1 52 ) $( seq 88 93 ) $( seq 99 -1 94 ) $( seq 100 105 ) $( seq 111 -1 106 ) $( seq 112 117 ) $( seq 123 -1 118 ) $( seq 154 159 ) $( seq  153 -1 148 ) $( seq 142 147 ) $( seq 141 -1 136 ) $( seq 130 135 ) $( seq 129 -1 124 ) $( seq 160 165 ) $( seq 171 -1 166 ) $( seq 172 177 ) $( seq 183 -1 178 ) $( seq 184 189 ) $( seq 195 -1 190 ) $( seq 226 231 ) $( seq 225 -1 220 ) $( seq 214 219 ) $( seq 213 -1 208 ) $( seq 202 207 ) $( seq 201 -1 196 ) $( seq 160 165 ) 129 93 99 105 111 117 123 51 45 39 33 ) 
WHEELLENGTH=${#COLORWHEEL[@]}
COLCOUNT=$(( $RANDOM ))

function change_colors
{
     FIRSTPROMPT=`echo $(echo -e "\u250C")$(pwd)`
     FIRSTLENGTH=${#FIRSTPROMPT}
     SECONDPROMPT=`echo $(echo -e "\u2514")$(echo -e "\u25B7")$(echo $USER@$HOSTNAME) $(echo -e "\u266B"):`
     SECONDLENGTH=${#SECONDPROMPT}
     COLOR=$(( $COLCOUNT % $WHEELLENGTH ))
     FINAL1=''
     FINAL2=''

     i=0
     while [ "$i" -le "$FIRSTLENGTH" ]; do
        CURRCOLOR=$(( ( $COLOR + $i ) % $WHEELLENGTH))
        FINAL1+="\[\033[38;5;${COLORWHEEL[$CURRCOLOR]}m\]${FIRSTPROMPT:$i:1}"
        i=$(($i + 1))
     done
     
     j=0
     while [ "$j" -le "$SECONDLENGTH" ]; do
        CURRCOLOR=$(( ( $COLOR + $j + 1 ) % $WHEELLENGTH))
	FINAL2+="\[\033[38;5;${COLORWHEEL[$CURRCOLOR]}m\]${SECONDPROMPT:$j:1}"
        j=$(($j + 1))
     done

     COLCOUNT=$(( $COLCOUNT + 1 ))
     PS1="${debian_chroot:+($debian_chroot)}${FINAL1}\n\[$(tput bold)\]${FINAL2} \[\e[0m\]"
}
PROMPT_COMMAND=change_colors






#if [ "$color_prompt" = yes ]; then
#    PS1=''
#else
#    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
#fi












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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

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

LS_COLORS=$LS_COLORS:'di=1;4;33:' ; export LS_COLORS

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
