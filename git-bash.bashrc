export LANG=en_US.UTF-8

# https://stackoverflow.com/questions/10488498/bash-history-does-not-update-in-git-for-windows-git-bash/10901227#10901227
PROMPT_COMMAND='history -a'

alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias ll="ls -lvAF --group-directories-first --sort=extension"
alias which="which --all"
alias diff="diff --strip-trailing-cr --color=auto"
# https://stackoverflow.com/questions/36841241/can-i-get-the-locate-to-work-on-windows-through-git-bash
alias updatedb='updatedb --localpaths='\''/c/'\'

# list environment variables
alias envs='env | sort | grep -P "^\w+?(?==)|"'
# list paths in PATH
alias path='echo "$PATH" | awk -F":" '\''{for(i=1;i<=NF;i++) print $i}'\'