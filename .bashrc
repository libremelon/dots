# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

# Configure Bitwarden SSH agent
export SSH_AUTH_SOCK="$HOME/.var/app/com.bitwarden.desktop/data/.bitwarden-ssh-agent.sock"
export PATH="/home/omen/.pixi/bin:$PATH"

# run cpp code 
rcpp() {
    clang++ "$1" -o out -std=c++23 && ./out && rm -r out
}

o() {
    if [ -z "$1" ]; then
        xdg-open "$(ls | fzf)"
    else
        xdg-open "$1"
    fi
}

# Aliases
alias sd="cd ~ && cd \"\$(fd -H -t d | fzf)\""
alias lg="lazygit"

source $PREFIX/share/fzf/key-bindings.bash 2> /dev/null || source /usr/share/fzf/shell/key-bindings.bash 

TMUX_CONF="$HOME/.config/tmux/tmux.conf"
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
    exec tmux -f "$TMUX_CONF" new-session -A -s main
fi
