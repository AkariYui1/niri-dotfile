# Plugin manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
# zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit snippet https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins/sudo/sudo.plugin.zsh

# Setup FZF keybinding (Ctrl + R)
eval "$(fzf --zsh)"

fastfetch

EDITOR=nvim

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
# bindkey -v
# End of lines configured by zsh-newuser-install
# The followi2 g lines were added by compinstall
zstyle :compinstall filename '/home/akariyui/.zshrc'

autoload -Uz compinit
compinit

# Detect AUR wrapper
if pacman -Qi yay &>/dev/null; then
   aurhelper="yay"
elif pacman -Qi paru &>/dev/null; then
   aurhelper="paru"
fi

function in {
    local -a inPkg=("$@")
    local -a arch=()
    local -a aur=()

    for pkg in "${inPkg[@]}"; do
        if pacman -Si "${pkg}" &>/dev/null; then
            arch+=("${pkg}")
        else
            aur+=("${pkg}")
        fi
    done

    if [[ ${#arch[@]} -gt 0 ]]; then
        sudo pacman -S "${arch[@]}"
    fi

    if [[ ${#aur[@]} -gt 0 ]]; then
        ${aurhelper} -S "${aur[@]}"
    fi
}

# Alias 
alias wasd='sudo pacman -S --needed --noconfirm'
alias dwasd='sudo pacman -Rnsc --noconfirm'
alias WASD='yay -S --needed --noconfirm'
alias DWASD='yay -Rnsc --noconfirm'

alias x11='env DISPLAY=:11'
# alias discord='env DISPLAY=:11 discord'

alias zshcfg='nvim .zshrc'
alias niricfg='nvim .config/niri/config.kdl'
alias grub-update='sudo grub-mkconfig -o /boot/gr'

alias c='clear' # clear terminal
alias l='eza -lh --icons=auto' # long list
alias ls='eza -1 --icons=auto' # short list
alias ll='eza -lha --icons=auto --sort=name --group-directories-first' # long list all
alias ld='eza -lhD --icons=auto' # long list dirs
alias lt='eza --icons=auto --tree' # list folder as tree
alias up='$aurhelper -Syu --noconfirm' # update system/package/aur
alias pl='$aurhelper -Qs' # list installed package
alias pa='$aurhelper -Ss' # list available package
alias pc='$aurhelper -Sc' # remove unused cache
alias po='$aurhelper -Qtdq | $aurhelper -Rns -' # remove unused packages, also try > $aurhelper -Qqd | $aurhelper -Rsu --print -
alias vc='env DISPLAY=:11 code' # gui code editor


export PATH=$PATH:/home/akariyui/.spicetify
