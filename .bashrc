# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
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
xterm-color | *-256color) color_prompt=yes ;;
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
xterm* | rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*) ;;
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

# (GJ) the above are "mostly" what was given in ubuntu
# the below are "custom" stuff

# exports
export EDITOR=nvim
export MANPAGER='nvim +Man!'

# env secrets that should not be in version control
if [ -f "$HOME/.ubuntu_env" ]; then
    . "$HOME/.ubuntu_env"
fi

# aliases
alias so="source ~/.bashrc"
alias q="exit"
alias c="clear"

# aliases - tools
alias ff="fastfetch"
alias cf="c & ff"
alias v="nvim"
alias lg="lazygit"

# aliases - screensavers
alias cm="cmatrix"
alias cb="cbonsai -li -L 64"
alias cn="nyancat -n"

# aliases - tmux
alias tm="tmux new -s"       # create tmux with session name
alias tmm="tmux new -s misc" # create tmux with session name "misc"
alias tma="tmux a"           # [a]ttatch tmux most recent session
alias tmat="tmux a -t"       # [a]ttatch tmux to [t]arget session name
alias tml="tmux ls"          # [l]ist all sessions
alias tmls="tml"
alias tmk="tmux kill-server" # [k]ill all sessions
alias tms="tmux-sessionizer" # /usr/bin/tmux-sessionizer -> /opt/tmux-sessionizer/tmux-sessionizer -> <the repo where the script is located>/tmux-sessionizer

# aliases - ubuntu specific
alias off="gnome-session-quit --power-off"
alias restart="gnome-session-quit --reboot"
alias logout="gnome-session-quit --logout"

# aliases - dotfiles
alias nvimrc="cd ~/.config/nvim"

# aliases - inotify
alias inotifyutil="~/.ubuntu_scripts/inotifyutil.sh"
alias ii="inotifyutil set" # [i]notify [i]ncrease
alias is="inotifyutil set"
alias ig="inotifyutil get"

# aliases - git
alias g="git"
alias gs="git status"
alias ga="git add"
alias gd="git diff"
alias gds="git diff --staged"
alias gc="git commit -m"
alias gf="git fetch"
alias gph="git push"
alias gpl="git pull"

# dotfile management
DOTFILES_HOME=$HOME
DOTFILES_GIT_DIR=.ubuntu_dotfiles
alias dotfiles="git --git-dir=$DOTFILES_HOME/$DOTFILES_GIT_DIR/ --work-tree=$DOTFILES_HOME"
alias ds="dotfiles status"
alias da="dotfiles add"
alias dd="dotfiles diff"
alias dds="dotfiles diff --staged"
alias dc="dotfiles commit -m"
alias df="dotfiles fetch"
alias dph="dotfiles push"
alias dpl="dotfiles pull"

# aliases - gemini
alias gemini-pro="gemini -m 'gemini-2.5-pro'"
alias gemini-flash="gemini -m 'gemini-2.5-flash'"

# aliases - project specific
alias opencode="bun run ~/Documents/SelfProjects/opencode/packages/opencode/src/index.ts"

# homebrew setup
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# Set up yazi - y shell wrapper
function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# Set up zoxide - z command and zi [i]nteractive command
eval "$(zoxide init bash)"

# nvm setup
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

# deno setup
. "/home/gjtiquia/.deno/env"
source /home/gjtiquia/.local/share/bash-completion/completions/deno.bash

# golang setup
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:$HOME/go/bin # for "global" installs via `go install <package>@<version>`

# workflow scripts (depends on everything else set up above)
alias s="~/start.sh" # typically symlinked to a script in ~/.ubuntu_scripts/
