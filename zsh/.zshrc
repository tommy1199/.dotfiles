export PATH="/opt/homebrew/bin:/Users/sascha/.local/bin:$PATH"

# If you come from bash you might have to change your $PATH.
export ZSH="/Users/sascha/.oh-my-zsh"

plugins=(
  cd-gitroot
  docker
  docker-compose
  git
  gradle
  kubectl
  zsh-autosuggestions
  zsh-syntax-highlighting
)

HISTFILE=$HOME/.zhistory
SAVEHIST=1000
HISTSIZE=999
setopt share_history 
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_verify

FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

source $ZSH/oh-my-zsh.sh

# User configuration
export JUST_SUPPRESS_DOTENV_LOAD_WARNING=1
export LANG=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim
export XDG_CONFIG_HOME="$HOME/.config"
export BAT_THEME="Catppuccin Macchiato"
export HOMEBREW_NO_ENV_HINTS=false

uao () {
  unzip $1
  (cd ${1:r} && idea .)
}

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
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
alias ls='eza --icons=always'
alias lla='ls -la --no-user --no-time'
alias tree='ls --tree'
alias treel='tree --long'
alias lg='lazygit'
alias vi="nvim"
alias vim="nvim"
alias cd="z"
alias flakedit="nvim ~/.dotfiles/nix-darwin/flake.nix"
function gi() { curl -sLw n https://www.toptal.com/developers/gitignore/api/$@ ;}

command -v kubectl >/dev/null && . <(kubectl completion zsh)
command -v kustomize >/dev/null && . <(kustomize completion zsh)
command -v timoni >/dev/null && . <(timoni completion zsh) && compdef _timoni timoni


export KUBECTL_EXTERNAL_DIFF="dyff between --omit-header --set-exit-code"


eval "$(fzf --zsh)"

show_file_or_dir_preview="if [ -d {} ]; then lsd --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_OPTS="--preview 'bat -n --color=always --line-range :500 {}'"
export FZF_ALT_C_OPTS="--preview 'lsd --color=always --tree {} | head -200'"

_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}

_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'lsd --color=always --tree {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \${}'"         "$@" ;;
    ssh)          fzf --preview 'dog --color=always {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

source ~/fzf-git.sh

source "$HOME/.sdkman/bin/sdkman-init.sh"

# Add pyenv to PATH
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$(go env GOPATH)/bin:${KREW_ROOT:-$HOME/.krew}/bin:$PATH:$HOME/.rd/bin:$HOME/.rvm/bin"

eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
eval "$(starship init zsh)"
eval "$(ngrok completion)"
eval "$(thefuck --alias fk)"

bindkey "^[[A" history-search-backward
bindkey "^[[B" history-search-forward

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/sascha/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/sascha/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/sascha/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/sascha/google-cloud-sdk/completion.zsh.inc'; fi
