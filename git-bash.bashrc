export LANG=en_US.UTF-8

# https://stackoverflow.com/questions/10488498/bash-history-does-not-update-in-git-for-windows-git-bash/10901227#10901227
PROMPT_COMMAND='history -a'

alias envs='env | sort | grep -P "^\w+?(?==)|"'
alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias ll="ls -lvAF --group-directories-first --sort=extension"
alias which="which --all"
