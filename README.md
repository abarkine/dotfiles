# RuntimeConfiguration
Current .bashrc of mine and other useful sources


![alt text](https://github.com/20percent/BashRuntimeConfiguration/blob/master/bashrcSS.PNG "Current look of bashrc")


current.bashrc -> Latest bashrc used by me


=======================================

# Console Shortcuts

CTRL-C - Halts the current command

CTRL-Z - Stops the current command (resume with fg in the foreground and bg in the background)

CTRL-D - Log out

CTRL-K - Deletes the line from the position of the cursor to the end of the line

CTRL-U - Erases the entire line

CTRL-W - Erases one word in the current line

!! - Repeats the last command

!$ - Repeats only the argument from the last command

^find^replace - Repeats the last command but replaces text

history - Shows your command line history

!123 - Runs the command associated with the numbers listed in the history above

mv /path/to/file.{txt,xml} - Brackets repeat the command with comma delimited changes

\ - Use at the end of a line to continue a multi-line command.

&& - Commands separated by a double ampersand means AND and runs multiple commands synchronously with each one running only if the last did not fail.

& - A single ampersand runs multiple commands asynchronously (at the same time).

trap '' SIGINT SIGQUIT SIGTSTP - ignore CTRL+C, CTRL+Z and quit singles using the trap

comment out "pam_motd" lines in /etc/pam.d/login and /etc/pam.d/sshd && set PrintLastLog as no in /etc/ssh/sshd_config - For discarding message(MOTD) that shown when you login your machine

echo "echo asil" >> /dev/stdin - Everything is a file under linux(stdin/stdout/stderr)

=======================================

# Cron Job Locations

/etc/cron.d

/etc/cron.daily

/etc/cron.hourly

/etc/cron.weekly

/etc/cron.monthly

=======================================

myScript needs MinimizeToTrayMenu script

autohotkey has been compiled with following method:

Ahk2Exe.exe /in "myScript.ahk" /icon "favicon.ico"
