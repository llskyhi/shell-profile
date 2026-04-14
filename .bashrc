export LANG=en_US.UTF-8

# https://stackoverflow.com/questions/10488498/bash-history-does-not-update-in-git-for-windows-git-bash/10901227#10901227
PROMPT_COMMAND='history -a'

alias grep="grep --color=auto"
alias ls="ls --color=auto"
alias ll="ls -lvAF --group-directories-first --sort=extension"
alias which="which --all"
alias diff="diff --strip-trailing-cr --color=auto"

# list environment variables
alias envs='env | sort | grep -P "^\w+?(?==)|"'
# list paths in PATH
alias path='echo "$PATH" | awk -F":" '\''{for(i=1;i<=NF;i++) print $i}'\'

# https://www.man7.org/linux/man-pages/man1/bash.1.html#PROMPTING
# https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
PS1=''                          # reset
PS1="$PS1"'\n'                  # new line
PS1="$PS1"'\[\033[90m\]'        # color: gray
PS1="$PS1"'\t '                 # HH:MM:SS
PS1="$PS1"'\[\033[32m\]'        # color: green
PS1="$PS1"'\u@\H '              # user@host
PS1="$PS1"'\[\033[35m\]'        # color: purple
PS1="$PS1"'$MSYSTEM '           # UCRT64, etc.
PS1="$PS1"'\[\033[33m\]'        # color: yellow
PS1="$PS1"'\w'                  # current working directory
# for Git for Windows: it should be included already
# for MSYS2: make '/etc/profile.d/' to have a '/usr/share/git/git-prompt.sh'
if $(command -v "__git_ps1" 2>&1 > /dev/null); then
    PS1="$PS1"'\[\033[36m\]'    # color: cyan
    PS1="$PS1"'`__git_ps1`'
fi
PS1="$PS1"'\[\033[0m\]'         # color: reset
PS1="$PS1"'\n'                  # new line
PS1="$PS1"'$ '                  # prompt character (# or $)
