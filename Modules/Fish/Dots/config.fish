function fish_greeting
    # random choice "Hello!" "Hi" "G'day" "Howdy"
end

# So vterm doesn't reply nicely, so it needs to not send a request for features
if [ "$INSIDE_EMACS" = "vterm" ]
    set -gx fish_features no-query-term
end

# This should allow the vterm window to have a nice title
function fish_title
    hostname
    echo ":"
    prompt_pwd
end

# I alliwng it to automatically find my doom commands
export PATH="$HOME/.config/emacs/bin:$PATH"

alias cd="z"
alias ngc="sudo nix-collect-garbage -d"
alias ngc7="sudo nix-collect-garbage --delete-older-than 7d"
alias ngc14="sudo nix-collect-garbage --delete-older-than 14d"
alias nixos="z /etc/nixos"
alias nrs="/etc/nixos/Scripts/nrs.sh"
alias windows="sudo grub-reboot 2 && sudo reboot"
alias cd="z"
alias ls="eza --icons --git -l"
alias bye="systemctl hibernate && fireplace"
alias byee="systemctl hibernate"
alias nd="nix develop -c fish"
alias v="nvim"
alias vi="nvim"
alias vim="nvim"
alias ssh="kitty +kitten ssh"


zoxide init fish | source
starship init fish | source
direnv hook fish | source
atuin init fish | source
