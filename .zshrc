# powerlevel10
ZLE_RPROMPT_INDENT=0

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi
#

export ZSH=~/.oh-my-zsh
ZSH_THEME="powerlevel10k/powerlevel10k"

unsetopt PROMPT_SP

zstyle ":completion:*" rehash true
zstyle ":completion:*" menu select

plugins=(
    git
    zsh-syntax-highlighting
    zsh-autosuggestions
    sudo
)

source $ZSH/oh-my-zsh.sh

#####

alias cls="clear"
alias rst="reset"

if command -v rsync &> /dev/null; then
    alias rcp='rsync --recursive --times --modify-window=2 --progress --verbose --itemize-changes --stats --human-readable --chmod=Du+rwx,go-rwx,Fu+rw,go-rw --no-perms'  
    alias rmv='rsync --remove-source-files --recursive --times --modify-window=2 --progress --verbose --itemize-changes --stats --human-readable --chmod=Du+rwx,go-rwx,Fu+rw,go-rw --no-perms'
else
    echo "'rsync' is not found"
fi

if command -v batman &> /dev/null; then
    alias man='batman'
else
    echo "'batman' is not found"
fi

if command -v rg &> /dev/null; then
    alias -g G="| rg"
else
    echo "'rg' is not found"
fi

if command -v batgrep &> /dev/null; then
    alias -g G="| batgrep"
else
    echo "'batgrep' is not found"
fi

eza_params=('--group-directories-first' '--icons=auto')

if command -v eza &> /dev/null; then
    alias ls="eza $eza_params"
    alias ll="eza -lh $eza_params"
    alias la="eza -lah $eza_params"
    alias tree="eza --tree $eza_params"
else
    echo "'eza' is not found"
fi

if command -v zoxide &> /dev/null; then
    alias z="zoxide"
else
    echo "'zoxide' is not found"
fi

if command -v yay &> /dev/null; then
    alias Y="yay"
    alias Ys="yay -S"
else
    echo "'yay' is not found"
    alias Y="pacman"
    alias Ys="pacman -S"
fi

if command -v grc &> /dev/null; then
    if [ -e ~/.grc.zsh ]; then
        source ~/.grc.zsh
    else
        echo "Warning: grc.zsh file is not found"
    fi
else
    echo "Wawrning: grc is not installed"
fi

if command -v mosh &> /dev/null; then
    alias mosh="mosh --no-init"
else
    echo "Wawrning: mosh is not installed"
fi

if command -v fuck &> /dev/null; then
    alias -g F="fuck"
else
    echo "Wawrning: thefuck is not installed"
fi

# powerlevel10
if [[ $DISPLAY || $WAYLAND_DISPLAY ]]; then
    POWERLEVEL9K_CONFIG_FILE="${HOME}/.p10k.zsh"
else
    POWERLEVEL9K_CONFIG_FILE="${HOME}/.p10k-tty.zsh"
fi

#

eval "$(thefuck --alias)"
eval "$(zoxide init --cmd cd zsh)"
eval "$(navi widget zsh)"

source /usr/share/doc/pkgfile/command-not-found.zsh

autoload -U compinit && compinit

export PROMT_COMMAND="history -a; history -r"
export HISTFILESIZE=1000000000
export HISTSIZE=1000000000

setopt HIST_IGNORE_ALL_DUPS
setopt INC_APPEND_HISTORY

[[ ! -f $POWERLEVEL9K_CONFIG_FILE ]] || source $POWERLEVEL9K_CONFIG_FILE

# Shell-GPT integration ZSH v0.1
_sgpt_zsh() {
if [[ -n "$BUFFER" ]]; then
    _sgpt_prev_cmd=$BUFFER
    BUFFER+="⌛"
    zle -I && zle redisplay
    BUFFER=$(sgpt --shell <<< "$_sgpt_prev_cmd")
    zle end-of-line
fi
}
zle -N _sgpt_zsh
bindkey ^l _sgpt_zsh
# Shell-GPT integration ZSH v0.1

function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}
