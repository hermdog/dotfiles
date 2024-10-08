# .bashrc

# Make tmux play nicely with SSH Agent forwarding
if [ -z ${TMUX+x} ]; then
  # If this is not a tmux session then symlink $SSH_AUTH_SOCK
  if [ ! -S ~/.ssh/ssh_auth_sock ] && [ -S "$SSH_AUTH_SOCK" ]; then
    ln -sf $SSH_AUTH_SOCK ~/.ssh/ssh_auth_sock
  fi
else
  # If this is a tmux session then use the symlinked SSH_AUTH_SOCK
  export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
fi


# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source aliases
if [ -f ~/.alias ]; then
    . ~/.alias
fi

# User specific aliases and functions
export PATH=~/bin:$PATH:/sbin:/usr/sbin:/var/adm/scripts

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

if [ -f ~/.flc_specific ]; then 
    . ~/.flc_specific
fi

export puppet6_dir='/home/bennetth/repos/puppet6'
