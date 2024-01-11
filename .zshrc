# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH="/Users/sascha/.local/bin:$PATH"

# If you come from bash you might have to change your $PATH.
export ZSH="/Users/sascha/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

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

eval "$(fnm env --use-on-cd)"

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

alias cat=bat
alias cdr='cd-gitroot'
alias clip="silicon --pad-horiz 0 --pad-vert 0 --background '#ffffff' --theme OneHalfDark --to-clipboard"
alias gcms="gaa && gcmsg 'Update' && gp"
alias grpo="git remote prune origin"
alias ls='lsd'
alias vi="nvim"
alias vim="nvim"

# The next line updates PATH for the Google Cloud SDK.
if [ -f ~/Downloads/google-cloud-sdk/path.zsh.inc ]; then source '/Users/sascha/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f ~/Downloads/google-cloud-sdk/completion.zsh.inc ]; then source '/Users/sascha/Downloads/google-cloud-sdk/completion.zsh.inc'; fi
export USE_GKE_GCLOUD_AUTH_PLUGIN=True

source <(kubectl completion zsh)
source <(kustomize completion zsh)
command -v timoni >/dev/null && . <(timoni completion zsh) && compdef _timoni timoni

eval "$(direnv hook zsh)"

export KUBECTL_EXTERNAL_DIFF="dyff between --omit-header --set-exit-code"
source "$(brew --prefix)/opt/kube-ps1/share/kube-ps1.sh"
PS1='$(kube_ps1)'$PS1

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export BAT_THEME="base16"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"
export RUBY_CONFIGURE_OPTS="--with-openssl-dir=$(brew --prefix openssl@1.1)"

source $(brew --prefix)/etc/profile.d/z.sh

source "$HOME/.sdkman/bin/sdkman-init.sh"

# Add pyenv to PATH
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$(go env GOPATH)/bin:${KREW_ROOT:-$HOME/.krew}/bin:$PATH:$HOME/.rd/bin:$HOME/.rvm/bin"
function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
