# If not running interactively, return from console
# This will disable connecting to machine from non-interactive shells such as VSCode's integrated terminal
#[ -z "$PS1" ] && return

# Coresize is unlimited
ulimit -c unlimited

# Append to the history file, don't overwrite it
shopt -s histappend
# Save all lines of a multiple-line command in the same history entry
shopt -s cmdhist
# Check the window size after each command and, if necessary, update the values of lines and columns
shopt -s checkwinsize

# Append history lines from all sessions to the history file
PROMPT_COMMAND='history -a'

# Setting history length
HISTSIZE=10000
HISTFILESIZE=20000
# Ignore commands
export HISTIGNORE="&:ls:[bf]g:exit"
# Ignore duplicate items and spaces
export HISTCONTROL=ignoredups:ignorespace

# Colorful bash
force_color_prompt=yes

# Override PS1 for asilelik
if [ ! -z "$PS1" ]; then
    export PS1="\n\[\033[0;31m\]asilelik\[$(tput sgr0)\]\[\033[0;37m\] @ \[$(tput sgr0)\]\[\033[0;32m\][\W]\[$(tput sgr0)\]\[\033[0;37m\] \\$ \[$(tput sgr0)\]"
fi

# Set PATH to reach common places
PATH=$PATH:/opt/cross/bin/:/usr/local:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/home/vagrant/bin/:/home/vagrant/

# Bind UP and DOWN keys for history search(same usage as Ctrl+R)
bind '"\e[A"':"history-search-backward"
bind '"\e[B"':"history-search-forward"

# Aliases for everyday usage
# Managing the computer
alias reboot='sudo /sbin/reboot'
alias poweroff='sudo /sbin/poweroff'
alias halt='sudo /sbin/halt'
alias shutdown='sudo /sbin/shutdown'
# Basic calculator
alias calc='bc -l'
# Create recycleBin folder if it does not exit
if [ ! -d "$HOME/.recycleBin" ]; then
  mkdir -p "$HOME/.recycleBin"
fi
# In order not to delete wrong file, move it to recycleBin first
alias rm='mv -t $HOME/.recycleBin'
alias rmdir='mv -t $HOME/.recycleBin'
# Delete everything in recycleBin permanently
alias removeP='/bin/rm -rf $HOME/.recycleBin/*'
# Edit .bashrc file
alias bedit='vi ~/.bashrc'
# Apply changes in .bashrc
alias refresh='source ~/.bashrc'
# Skim the file; read the first and last 5 lines
alias skim="(head -5; tail -5) <"
# Ping 3 times with 200ms intergval
alias ping='ping -c 3 -i 0.2'
# Override mkdir in order to see no error if existing, make parent directories as needed
alias mkdir='mkdir -p'
# My most used command to list directory
alias ll='ls -alF --color=auto'
# Colorful grep
alias grep='grep --color=auto'
# Lazy alias (gained time 0.0000473 seconds)
alias apt='sudo apt-get'
# Force kill
alias killf='kill -9'
# Gracefully kill
alias killg='kill -15'

# Functions
# ClamAV - Antivirus / update definitions and run from given folder recursively(default: "/")
# It will run in background and displays infected files
function antivirus()
{
    sudo freshclam
    if [ -z "$1" ]; then
        clamscan -r -i / &
    else
        clamscan -r -i "$1" &
    fi
}
# Service operations
# Usage: sservice {service_name} status/restart/start/stop
function sservice()
{
    if [ "$#" = 2 ] ; then
        CALLEDSERVICE="/etc/init.d/$1"
        case $2 in
                start ) $CALLEDSERVICE start;;
                stop ) $CALLEDSERVICE stop;;
                restart ) $CALLEDSERVICE restart;;
                status ) $CALLEDSERVICE status;;
                *) echo "Usage: sservice {service_name} status/restart/start/stop" ;;
        esac
    else
        echo "Usage: sservice {service_name} status/restart/start/stop"
    fi
}
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
# Look for filenames which includes $1 recursively; starting directory $2(default: ".")
function ffile()
{
    if [ ! -z "$1" ]; then
        if [ -z "$2" ]; then
            find . -name "*$1*"
        else
            find "$2" -name "*$1*"
        fi
    fi
}
# Searches for $1 recursively; starting directory $2(default: ".")
function ftext ()
{
    if [ ! -z "$1" ]; then
        if [ -z "$2" ]; then
            grep -iIHrnF --color=always "$1" .
        else
            grep -iIHrnF --color=always "$1" "$2"
        fi
    fi
}
# Call sudo with followed command or use latest command that you run
function su()
{
    if [[ $# == 0 ]]; then
        sudo $(history -p '!!')
    else
        sudo "$@"
    fi
}
# Extract all kinds of files
# Usage: extract dummy.tar.gz
function extract ()
{
  if [ -f "$1" ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf "$1"    ;;
          *.tar.gz)    tar xvzf "$1"    ;;
          *.bz2)       bunzip2 "$1"     ;;
          *.rar)       rar x "$1"       ;;
          *.gz)        gunzip "$1"      ;;
          *.tar)       tar xvf "$1"     ;;
          *.tbz2)      tar xvjf "$1"    ;;
          *.tgz)       tar xvzf "$1"    ;;
          *.zip)       unzip "$1"       ;;
          *.Z)         uncompress "$1"  ;;
          *.7z)        7z x "$1"        ;;
          *)           echo "Don't know how to extract" "$1" ;;
      esac
  else
      echo "'$1' is not a valid file :("
  fi
}
# Compress all kinds of files
# Usage: compress dummy.tar.gz files/folders (default: compress everything in current folder)
function compress ()
{
    if [ ! -z "$1" ]; then
        if [ -z "$2" ]; then
            case $1 in
                    *.tar ) tar cf "$1" * ;;
                    *.tar.bz2 ) tar cjf "$1" * ;;
                    *.tar.gz ) tar czf "$1" * ;;
                    *.tgz ) tar czf "$1" * ;;
                    *.zip ) zip "$1" * ;;
                    *.rar ) rar "$1" * ;;
                    *) echo "Don't know how to compress" "$1" ;;
            esac
        else
            FILESAVALIABLE=true
            for var in "${@:2}"
            do
                if [ ! -f $var ] ; then
                    FILESAVALIABLE=false
                    echo "$var cannot be found :("
                fi
            done
            if [ "$FILESAVALIABLE" = true ] ; then
                FILE=$1
                case $1 in
                    *.tar ) shift && tar cf $FILE $* ;;
                    *.tar.bz2 ) shift && tar cjf $FILE $* ;;
                    *.tar.gz ) shift && tar czf $FILE $* ;;
                    *.tgz ) shift && tar czf $FILE $* ;;
                    *.zip ) shift && zip $FILE $* ;;
                    *.rar ) shift && rar $FILE $* ;;
                    *) echo "Don't know how to compress '$1' :(" ;;
                esac
            fi
        fi
    fi
}
# Go upwards
# Usage: up 3 -> results in cd ../../..
function up(){
    local d=""
    limit=$1
    for ((i=1 ; i <= limit ; i++))
    do
        d=$d/..
    done
    d=$(echo $d | sed 's/^\///')
    if [ -z "$d" ]; then
        d=..
    fi
    cd $d || return 0
}
# Temporarily add given directory to the PATH
function temp_path()
{
    if [ $# -lt 1 ] || [ $# -gt 2 ]; then
        echo "Temporarily add to PATH"
        echo "usage: apath [dir]"
    else
        PATH=$1:$PATH
    fi
}
# Backup file with date-time stamp
# Create backup folder if it does not exit
if [ ! -d "$HOME/.backup" ]; then
    mkdir -p "$HOME/.backup"
fi
# Usage "backup filename.txt"
function backup()
{
    FILENAMETOBACKUP=$1-`/bin/date +%Y%m%d%H%M`.backup
    DEST="$HOME/.backup/$FILENAMETOBACKUP"
    cp "$1" "$DEST"
}
# Which package offers this command
function which_command()
{
    PACKAGE=$(dpkg -S "$(which "$1")" | cut -d':' -f1)
    echo "[${PACKAGE}]"
    dpkg -s "${PACKAGE}"
}
# Launch applications in background
function daemon()
{
    (exec "$@" >&/dev/null &)
}
#Quick C++ hello world
function quickCpp()
{
    mkdir -p temp
    cd temp
    touch temp.cpp
    echo "#include <stdio.h>" >> temp.cpp
    echo >> temp.cpp
    echo "int main(int argc, char **argv)" >> temp.cpp
    echo "{" >> temp.cpp
    echo "    printf(\"Hello world!\");" >> temp.cpp
    echo "    return 0;" >> temp.cpp
    echo "}" >> temp.cpp
    g++ -o temp temp.cpp
    chmod +x temp
    ./temp
}
###### Machine details
function computer()
{
    echo
    echo "Your username is" $(whoami)
    echo "Current date is" $(/bin/date)
    echo "Last system boot happened at" $(who -b | awk '{print $3, $4}')
    echo
    echo "Latest activities in system:"
    last -n 10 | head -n -2
    echo
    echo "============================== System =============================="
    echo
    echo "Operating system:" $(uname -o)
    echo "Kernel release and version:" $(uname -rv)
    echo "Architecture:" $(uname -i)
    echo "Software version:" $(lsb_release -d | awk '{print $2,$3,$4}')
    echo "Hostname:" $(hostname -s)
    echo "FQDN:" $(hostname -f)
    echo
    echo "============================== Network =============================="
    echo
    echo "IP address:" $(hostname -i)
    echo "External IP Address:" $(curl -s http://whatismyip.akamai.com/)
    echo "DNS IP(s):" $(sed -e '/^$/d' /etc/resolv.conf | awk '{if (tolower($1)=="nameserver") print $2}')
    echo "Network interfaces:" $(netstat -i | cut -d" " -f1 | egrep -v "^Kernel|Iface|lo")
    echo "All addresses that assigned to host:" $(hostname -I)
    echo
    echo "=============== Overall network information ==============="
    netstat
    echo
    echo "=============== Interface information ==============="
    ip -4 address show
    echo
    echo "=============== Kernel interface table ==============="
    netstat -i | sed -n '1!p'
    echo
    echo "=============== Numeric routing table ==============="
    netstat -nr | sed -n '1!p'
    echo
    echo "=============== Open ports that listens for connection ==============="
    netstat -l | sed -n '1!p'
    echo
    echo "=============== IFCONFIG results ==============="
    IFCONFIG=(/sbin/ifconfig)
    $IFCONFIG | awk /'inet addr/ {print $2}'
    echo
    $IFCONFIG | awk /'Bcast/ {print $3}'
    echo
    $IFCONFIG | awk /'inet addr/ {print $4}'
    $IFCONFIG | awk /'HWaddr/ {print $4,$5}'
    echo
    echo "============================== Memory =============================="
    echo
    echo "=============== Information about partitions ==============="
    df -ah
    echo
    echo "=============== Information about CPU ==============="
    lscpu
    echo
    echo "=============== Memory distribution ==============="
    free -m -l -t
    echo
    echo "=============== Top 10 RAM lovers ==============="
    ps auxf | sort -nr -k 4 | head -12 | grep -v %MEM
    echo
    echo "=============== Top 10 CPU lovers ==============="
    ps auxf | sort -nr -k 3 | head -12 | grep -v %MEM
}
# Have fun with other users in same system
function scream()
{
    if [ ! -z $1 ]; then
        echo $1 | wall
    fi
}
# Override date function
function adate()
{
    year=$(/bin/date +"%Y")
    monthname=$(/bin/date +"%B")
    daynumber=$(/bin/date +"%d")
    dayname=$(/bin/date +"%A")
    time=$(/bin/date +"%T")
    echo "$time - $dayname, $daynumber $monthname $year"
}
# Greeting function
function greetings()
{
    clear
    # You may create an ASCII art here
    echo
    echo
    # Past, current and next month, Monday as starting day to week
    ncal -3MC
    echo
    echo
    echo
    # Daily message
    YOURNAME="Asil"
    hour=$(/bin/date +"%H")
    if [ $hour -ge 6 -a $hour -lt 12 ]
    then
        echo "Good morning, $YOURNAME. You didn't sleep well, did you?'"
    elif [ $hour -ge 12 -a $hour -lt 18 ]
    then
        echo "Good afternoon, $YOURNAME. I hope, morning was good enough."
    elif [ $hour -ge 18 -a $hour -lt 24 ]
    then
        echo "Good evening, $YOURNAME. You are working even after your workhours."
    else
        echo "Good night, $YOURNAME. Isn't it a little bit late?'"
    fi
    echo
    day=$(/bin/date +"%B%e")
    case $day in
        "August3") echo ":O It is your birthday";;
        "August19") echo "It is asd's birthday.";;
        *) adate;;
    esac
    echo
}

# Check for interactive shell before running echo commands
# This will prevent errors that you will get when you use scp
# Issue: https://bugzilla.redhat.com/show_bug.cgi?id=20527
# Solution: http://stackoverflow.com/questions/21076725/net-scp-waiting-until-time-out-in-capistranos-gitwrapper-task/41192334#41192334
[ ! -z "$PS1" ] && greetings
