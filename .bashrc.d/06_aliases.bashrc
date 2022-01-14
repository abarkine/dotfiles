# -A => do not list implied . and ..
# -l => use a long listing format
# -F => append indicator (one of */=>@|) to entries
alias ll='ls -AlF'

# Use markers to highlight the matching strings
alias grep='grep --color=always'

# Make unified diff syntax the default
alias diff='diff -u'

# Canonical hex+ASCII display
alias hexdump='hexdump -C'

# Reload RC
alias refresh='source ~/.bashrc'

# -c => Stop after sending count
# -i => Wait interval seconds between sending each packet
alias ping='ping -c 3 -i 0.2'

# Skim the file; read the first and last 5 lines
alias skim='(head -5;printf "\n---------------------\n"; tail -5) <'

# -p => no error if existing, make parent directories as needed
alias mkdir='mkdir -p'

# Force kill
alias killf='sudo kill -9'

# Gracefully kill
alias killg='sudo kill -15'

# -a => display all locations containing an executable
alias which='type -a'

# Dump current PATH definitions
alias paths='echo -e ${PATH//:/\\n}'

# Search filename in current directory, recursively
alias qf='find . -name '

# Quick server in current directory
alias qs='busybox httpd -f -p 8473'

# Check journal for service
alias ql='sudo journalctl --no-pager -u '
