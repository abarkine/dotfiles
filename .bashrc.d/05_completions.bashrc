# Autocomplete ls with directories
complete -d ls

# Example wordlist for ping
# complete -W 'asil.dev google.com' ping

# Example method for autocomplete generation
# _programX_autocomplete()
# {
#   local curr_arg;
#   curr_arg=${COMP_WORDS[COMP_CWORD]}
#   COMPREPLY=($(compgen -W '-i --incoming -o --outgoing -m --missed' -- $curr_arg ));
# }
# complete -F _programX_autocomplete ./programX
