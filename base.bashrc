# If not running interactively, don't do anything
[ -z "$PS1" ] && return

for file in ~/projects/dotfiles/.bashrc.d/*.bashrc
do
  source "$file"
done
