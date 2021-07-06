# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source aliases
if [ -f ~/.alias ]; then
    . ~/.alias
fi

# User specific aliases and functions
export PATH=~/bin:$PATH:/sbin:/usr/sbin

# My Fancy PS1 defined here.
if [ $(id -u) -eq 0 ]
then
  PS1="[\u@\h \w]# "
else
  PS1="\[\e[0;31m\]\u\[\e[0;34m\]@\[\e[0;32m\]\h\[\e[0;34m\]:\[\e[0;33m\]\w\n\[\e[0;31m\]$ \[\e[0m\]"
fi

# What todo if running on WSL
if [[ "$(< /proc/sys/kernel/osrelease)" == *icrosoft* ]]; then
  export PATH="~/.local/bin:$PATH"

  ## this is used to setup ssh-agent
  ## requires keychain installed
  /usr/bin/keychain -q --nogui $HOME/.ssh/github_key
  source $HOME/.keychain/$HOSTNAME-sh
fi
