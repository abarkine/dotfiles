export PATH=$HOME/bin:/usr/local/bin:/Applications:/usr/local:/usr/local/curl:/usr/local/sbin:/usr/sbin:/usr/bin:/sbin:/bin:$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH
export LDFLAGS="-L/usr/local/curl/lib"
export CPPFLAGS="-I/usr/local/curl/include"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
export ZSH="/Users/asilelik/.oh-my-zsh"
ZSH_THEME="agnoster"
DISABLE_UNTRACKED_FILES_DIRTY="true"
DEFAULT_USER=$(whoami)
plugins=(git docker-compose)

source $ZSH/oh-my-zsh.sh

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='vim'
fi

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000000
SAVEHIST=10000000
HIST_STAMPS="dd.mm.yyyy"
setopt BANG_HIST                 # Treat the '!' character specially during expansion.
# setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing nonexistent history.

# Alias
alias refresh='source ~/.zshrc'
alias ping='ping -c 3 -i 0.2'
alias ll='ls -al'
alias api="cd /Users/asilelik/speakap/Speakap-API"
alias dload="make dload-fixtures"
alias gdev="git checkout development"
alias gcr="git checkout -b"
alias dup="docker-compose up -d"
alias down="docker-compose down"
alias dlog="docker-compose logs -f"
alias dex="docker-compose exec"
alias dbuild="docker build -t php/extension ."
alias drun="docker run -it php/extension"
alias drunfile='docker run -it --rm -v "$PWD/extension.php":/usr/src/extension-tutorial/extension.php php/extension'
alias brewuu="brew update && brew upgrade"

function update()
{
    cd $1
    for i in */.git; do ( echo $i; cd $i/..; git pull; ); done
    cd -
}

# Functions
# SCP Send/Receive - Port number is not mandatory
# Usage(send): transfer send {path_for_file_to_send} {remote_username} {remote_address} {remote_folder_path} {port_number}
# Usage(receive): transfer receive {remote_username} {remote_address} {remote_file_path} {path_for_file_to_receive} {port_number}
function transfer()
{
    if [ "$#" -ne 5 ] || [ "$#" -ne 6 ]; then
        echo "Usage(send): transfer send {path_for_file_to_send} {remote_username} {remote_address} {remote_folder_path} {port_number}"
        echo "Usage(receive): transfer receive {remote_username} {remote_address} {remote_file_path} {path_for_file_to_receive} {port_number}"
    fi

    if [ "$1" = "send" ] ; then
        if [ -z "$6" ]; then
            scp "$2" "$3@$4:$5"
        else
            scp "$2" "$3@$4:$5" -p "$6"
        fi
    elif [ "$1" = "receive" ]; then
        if [ -z "$6" ]; then
            scp "$2@$3:$4" "$5"
        else
            scp -p "$6" "$2@$3:$4" "$5"
        fi
    else
        echo "Usage(send): transfer send {path_for_file_to_send} {remote_username} {remote_address} {remote_folder_path} {port_number}"
        echo "Usage(receive): transfer receive {remote_username} {remote_address} {remote_file_path} {path_for_file_to_receive} {port_number}"
    fi
}

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
