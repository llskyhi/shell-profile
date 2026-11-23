alias ~="cd ~"
# 2026-06-18: `alias -=...` will not simply work cuz `-=` is recognized as an unknown option (-=: invalid option).
#             Not sure why but inserting `--` seems to work.
alias -- -="cd -"
alias ..="cd ../"

alias ls="ls --color=auto"
alias ll="ls -lvAF --group-directories-first --sort=extension"
alias grep="grep --color=auto"
alias which="which --all"
alias diff="diff --strip-trailing-cr --color=auto"

# list environment variables
alias envs='env | sort | grep -P "^\w+?(?==)|"'
# list paths in PATH
alias path='echo "$PATH" | awk -F":" '\''{for(i=1;i<=NF;i++) print $i}'\'
