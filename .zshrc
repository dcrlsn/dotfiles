setopt auto_cd

# find out which distribution we are running on
LFILES=(/etc/*-release(N))
MFILE="/System/Library/CoreServices/SystemVersion.plist"

if [[ -n "$LFILES" && -f "$LFILES[1]" ]]; then
 if [[ -d "/usr/share/pve-manager" ]]; then
  _distro="proxmox"
 else
  LFILE="/etc/*-release" 
 LFILE=$LFILES[1]
  . "$LFILE"
  _distro=$(awk '/^ID=/' /etc/*-release | awk -F'=' '{ print tolower($2) }')
 fi
elif [[ -f "$MFILE" ]]; then
  _distro="macos"
fi


# set an icon based on the distro
# make sure your font is compatible with https://github.com/lukas-w/font-logos
case $_distro in
*kali*) ICON="ﴣ" ;;
*arch*) ICON="" ;;
*debian*) ICON="" ;;
*raspbian*) ICON="" ;;
*ubuntu*) ICON="" ;;
*elementary*) ICON="" ;;
*fedora*) ICON="" ;;
*coreos*) ICON="" ;;
*gentoo*) ICON="" ;;
*mageia*) ICON="" ;;
*centos*) ICON="" ;;
*opensuse* | *tumbleweed*) ICON="" ;;
*sabayon*) ICON="" ;;
*slackware*) ICON="" ;;
*linuxmint*) ICON="" ;;
*alpine*) ICON="" ;;
*aosc*) ICON="" ;;
*nixos*) ICON="" ;;
*devuan*) ICON="" ;;
*manjaro*) ICON="" ;;
*rhel*) ICON="" ;;
*macos*) ICON=" " ;;
*freebsd*) ICON="" ;;
*proxmox*) ICON="" ;;
*) ICON="" ;;
esac

export STARSHIP_DISTRO="$ICON"

#kubernetes
kn() {
  if [ "$1" != "" ]; then
    kubectl config set-context --current --namespace=$1
  else
    echo -e "\e[1;31m Error, please provide a valid Namespace\e[0m"
  fi
}

knd() {
  kubectl config set-context --current --namespace=default
}

ku() {
  kubectl config unset current-context
}

#pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

#nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Add Visual Studio Code (code)
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

#pipenv
[ -x "$(command -v pipenv)" ] && export PIPENV_PYTHON="$PYENV_ROOT/shims/python" && export WORKON_HOME="$HOME/.pyenv/versions"

#viimed
if [ -n "$(ls -A "$HOME/.local/bin/viimed/" 2>/dev/null)" ]; then
  export PATH="$PATH:$HOME/.local/bin/viimed/scripts"
  source $HOME/.local/bin/viimed/.viimed_env_vars
fi

#react
REACT_EDITOR=code

#OMZ
export ZSH="$HOME/.oh-my-zsh"

if [[ -n $PS1 ]]; then
  : # These are executed only for interactive shells
  # Load Starship
  eval "$(starship init zsh)"
  # Load OMZ
  source $ZSH/omz.conf
  ### Aliases
  [ -x "$(command -v nvim)" ] && alias vi="nvim"
  [ -x "$(command -v exa)" ] && alias ls="exa -h --icons --group-directories-first"
  alias \
    config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME" \
    hg="kitty +kitten hyperlinked_grep" \
    lx="ls --hyperlink=auto" \
    ll="ls -l" \
    grep="grep --color=auto" \
    cp="cp -v" \
    mv="mv -v" \
    rm="rm -v" \
    mkdir="mkdir -pv" \
    diff="diff --color=auto" \
    updatenode="nvm install lts/gallium --reinstall-packages-from=current" \
    k="kubectl" \
    h="helm"
else
  : # Only for NON-interactive shells
fi


export STARSHIP_DISTRO="$ICON"
