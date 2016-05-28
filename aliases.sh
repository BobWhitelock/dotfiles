

# Some ls aliases.
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

function cl() {
    cd "$@" && l
}

# Misc aliases.
alias tree="tree -C -a --filelimit 50"
alias pyserver="python -m SimpleHTTPServer 8000"

# Git aliases.
alias g='git'
alias gp='git push'
alias gpl='git pull --prune'
alias glog="git log --graph --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%ar / %cr)%Creset' --abbrev-commit --date=relative"
alias glogall='glog --all'
alias gd='git diff --color'
alias gdc='git diff --cached'
alias gg='git grep'
alias gbl='git blame'
alias gst='git stash'
alias gc='git commit'
alias gca='git commit -a'
alias ga='git add'
alias gco='git checkout'
alias gr='git reset'
alias gb='git branch'
alias gs='git status -sb'
alias gsh='git show'
alias gbi='git bisect'
alias gbis='git bisect start'
alias gbir='git bisect reset'
alias gbib='git bisect bad'
alias gbig='git bisect good'

# Alces aliases/functions.
alias pscreen='cd ~/alces-portal && screen -dr portal'
alias plog='cd ~/alces-portal && less log/development.log'
alias pconsole='cd ~/alces-portal && bin/rails console'
alias ppostgres='cd ~/alces-portal && psql portal'
alias pdir='cd ~/alces-portal'

alias pvm='sshpass -p alces ssh portalvm'
alias vacsvm='ssh bob@127.0.0.1 -p 9322'

# Kill/clean any running/leftover Clusterware sessions.
function alces_kill_all_sessions() {
    for i in $(alces session list | cut -d ' ' -f 2 | tail -n +4 | head -n -1); do
        alces session kill $i
    done
    alces session clean
}

# Shortcuts for frequent xrandr commands.
alias xrandr_laptop_single='xrandr \
    --output DP2 --off \
    --output DP1 --off \
    --output HDMI3 --off \
    --output HDMI2 --off \
    --output HDMI1 --off \
    --output eDP1 --mode 1920x1080 --pos 0x0 --rotate normal \
    --output VGA1 --off \
    && conkywonky'
alias xrandr_laptop_dual='xrandr \
    --output DP2 --off \
    --output DP1 --off \
    --output HDMI3 --off \
    --output HDMI2 --off \
    --output HDMI1 --mode 1920x1080 --pos 1920x0 --rotate normal \
    --output eDP1 --mode 1920x1080 --pos 0x0 --rotate normal \
    --output VGA1 --off \
    && conkywonky'
alias xrandr_laptop_triple='xrandr \
    --output DP2 --off \
    --output DP1 --off \
    --output HDMI3 --off \
    --output HDMI2 --off \
    --output HDMI1 --mode 1920x1080 --pos 1440x900 --rotate normal \
    --output eDP1 --mode 1360x768 --pos 80x900 --rotate normal \
    --output VGA1 --mode 1440x900 --pos 0x0 --rotate normal \
    && conkywonky'

function xrandr_off() {
    for output in "$(xrandr | cut -d ' '  -f 1 | grep -i "$@")"; do
        xrandr --output "$output" --off
    done
    conkywonky
}

# Let vim interpret commands which would be interpreted by the terminal
# otherwise; not quite sure of purpose of ttyctl here (from
# http://vim.wikia.com/wiki/Map_Ctrl-S_to_save_current_or_new_files).
alias vim="stty stop '' -ixoff ; vim"
ttyctl -f

# Listing and removing swp files.
swps_path="~/.vim/swps/*sw?"
alias swps="ls -l $swps_path"
alias swp_cleanup="rm $swps_path"
unset swps_path

# Ease transition between shell and vim.
alias :q="exit"

# Because I can never remember how to do this.
function whats-blocking-port() {
    if [ -z "$1" ]; then
        sudo netstat -tulpn
    else
        sudo netstat -tulpn | grep ":$1[[:space:]]"
    fi
}

# Swap 2 filenames around, if they exist (from Uzi's bashrc).
# From http://tldp.org/LDP/abs/html/sample-bashrc.html.
function swap() {
    local TMPFILE=tmp.$$

    [ $# -ne 2 ] && echo "swap: 2 arguments needed" && return 1
    [ ! -e $1 ] && echo "swap: $1 does not exist" && return 1
    [ ! -e $2 ] && echo "swap: $2 does not exist" && return 1

    mv "$1" $TMPFILE
    mv "$2" "$1"
    mv $TMPFILE "$2"
}

# Handy Extract Program.
# From http://tldp.org/LDP/abs/html/sample-bashrc.html.
function extract() {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

function yaml_validate() {
    ruby -e "require 'yaml'; YAML.load_file('$1')"
}
