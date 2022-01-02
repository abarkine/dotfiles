# If not running interactively, don't do anything
[ -z "$PS1" ] && return

for RC_FILE in ~/projects/dotfiles/.bashrc.d/*.bashrc
do
  source "$RC_FILE"
done
