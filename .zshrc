export PATH="/Users/sascha/.local/bin:$PATH"

# If you come from bash you might have to change your $PATH.
export ZSH="/Users/sascha/.oh-my-zsh"

plugins=(
  cd-gitroot
  docker
  docker-compose
  git
  kubectl
  zsh-autosuggestions
  zsh-syntax-highlighting
)

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh

# User configuration
export JUST_SUPPRESS_DOTENV_LOAD_WARNING=1


export LANG=en_US.UTF-8

uao () {
  unzip $1
  (cd ${1:r} && idea .)
}

mkcd () {
  case "$1" in
    */..|*/../) cd -- "$1";; # that doesn't make any sense unless the directory already exists
    /*/../*) (cd "${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd -- "$1";;
    /*) mkdir -p "$1" && cd "$1";;
    */../*) (cd "./${1%/../*}/.." && mkdir -p "./${1##*/../}") && cd "./$1";;
    ../*) (cd .. && mkdir -p "${1#.}") && cd "$1";;
    *) mkdir -p "./$1" && cd "./$1";;
  esac
}

alias cat='bat -p'
alias cdr='cd-gitroot'
alias clip="silicon --pad-horiz 0 --pad-vert 0 --background '#ffffff' --theme OneHalfDark --to-clipboard"
alias gcms="gaa && gcmsg 'Update' && gp"
alias grpo="git remote prune origin"
alias ls='lsd'
alias lla='ls -la'
alias tree='ls --tree'
alias treel='tree --long'
alias lg='lazygit'
alias vi="nvim"
alias vim="nvim"
alias cd="z"
function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

source <(kubectl completion zsh)
source <(kustomize completion zsh)
command -v timoni >/dev/null && . <(timoni completion zsh) && compdef _timoni timoni


export KUBECTL_EXTERNAL_DIFF="dyff between --omit-header --set-exit-code"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export BAT_THEME="gruvbox-dark"

source "$HOME/.sdkman/bin/sdkman-init.sh"

# Add pyenv to PATH
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$(go env GOPATH)/bin:${KREW_ROOT:-$HOME/.krew}/bin:$PATH:$HOME/.rd/bin:$HOME/.rvm/bin"

eval "$(direnv hook zsh)"
eval "$(fnm env --use-on-cd)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
