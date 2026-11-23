ANSI_CODE_RESET='\033[0m'
ANSI_CODE_ITALIC='\033[3m'
ANSI_CODE_RED='\033[31m'
ANSI_CODE_GREEN='\033[32m'
ANSI_CODE_YELLOW='\033[33m'
ANSI_CODE_PURPLE='\033[35m'
ANSI_CODE_CYAN='\033[36m'
ANSI_CODE_GRAY='\033[90m'
# Enclose non-printing characters with \[ \] for PS1.
# See man bash(1) or https://stackoverflow.com/a/17434281/25956559
function __enclose_npc() {
    local non_printing_characters="$1"
    echo '\['"$non_printing_characters"'\]'
}
# https://www.man7.org/linux/man-pages/man1/bash.1.html#PROMPTING
# https://en.wikipedia.org/wiki/ANSI_escape_code#Colors
# 2026-09-23: it's found there's a bug on MSYS2 bash (also affects Git Bash)
#             when using command substitution (the "$(...)" syntax) and newline (\n) together in PS1.
#             The bug still consists as of write using version 5.3.15(1)-release.
# https://github.com/msys2/MSYS2-packages/issues/1839
# https://stackoverflow.com/a/21561763/25956559
PS1=''                          # reset
PS1="$PS1""$(__enclose_npc "$ANSI_CODE_RESET")"
PS1="$PS1""$(__enclose_npc "$ANSI_CODE_GRAY")"
PS1="$PS1"'\t '                 # HH:MM:SS
PS1="$PS1""$(__enclose_npc "$ANSI_CODE_GREEN")"
PS1="$PS1"'\u@\H '              # user@host
PS1="$PS1""$(__enclose_npc "$ANSI_CODE_PURPLE")"
PS1="$PS1"'$MSYSTEM '           # UCRT64, etc.
PS1="$PS1""$(__enclose_npc "$ANSI_CODE_YELLOW")"
PS1="$PS1"'\w'                  # current working directory
# for Git for Windows: it should be included already
# for MSYS2: ensure '/etc/profile.d/' to have a 'git-prompt.sh',
#            which should be 'ucrt64/share/git/completion/git-prompt.sh' for UCRT64 variant package
#            or 'usr/share/git/completion/git-prompt.sh' for base 'git' package.
#            Path are related to MSYS2 installation root.
if $(command -v "__git_ps1" 2>&1 > /dev/null); then
    PS1="$PS1""$(__enclose_npc "$ANSI_CODE_CYAN")"
    PS1="$PS1"'$(__git_ps1)'
fi
PS1="$PS1""$(__enclose_npc "$ANSI_CODE_RESET")"
PS1="$PS1"$'\n'                 # new line
PS1="$PS1"'\$ '                 # prompt character (# or $)
PS1="$PS1""$(__enclose_npc "$ANSI_CODE_RESET")"


COMMAND_START_TIME_FILE_PATH="/dev/shm/command-start-time-shell-pid-$$"
function __ps0() {
    date +%s > "$COMMAND_START_TIME_FILE_PATH"
}
PS0='$(__ps0)'

function __print_last_command_execution_info() {
    local exit_code="$1"
    local command_elapsed_seconds="$2"
    local output

    output=''
    output="$output""$ANSI_CODE_ITALIC"
    output="$output""$ANSI_CODE_GRAY"
    output="$output""("

    # exit code
    if [ $exit_code -ne 0 ]; then
        output="$output""$ANSI_CODE_RED"
    else
        output="$output"
    fi
    output="$output""exit code: $exit_code"
    output="$output""$ANSI_CODE_GRAY"

    # elapsed time in seconds
    output="$output"", ${command_elapsed_seconds:-"N/A"} seconds elapsed"

    output="$output"")"
    output="$output""$ANSI_CODE_RESET"
    echo -e "$output"
}

function __prompt_command() {
    local exit_code="$?"
    local command_start_time
    local command_end_time=$(date +%s)
    local command_elapsed_seconds

    # When it's first prompt, no need for the last command execution info.
    if [ "$is_not_first_prompt" != 'yes' ] ;  then
        is_not_first_prompt='yes'
        return
    fi

    if [ -s "$COMMAND_START_TIME_FILE_PATH" ]; then
        command_start_time=$(cat "$COMMAND_START_TIME_FILE_PATH")
        command_elapsed_seconds=$((command_end_time - command_start_time))
        # Remove the command start time file, otherwise shell inputs that does not trigger PS0 (e.g. press enter directly)
        # will leave this unrefreshed and cause unwanted elapsed time.
        rm "$COMMAND_START_TIME_FILE_PATH"
    fi

    # A newline for distinguishing/separating last command output and next command prompt.
    echo

    __print_last_command_execution_info "$exit_code" "$command_elapsed_seconds"

    # for Git Bash
    # https://stackoverflow.com/questions/10488498/bash-history-does-not-update-in-git-for-windows-git-bash/10901227#10901227
    # history -a
}

# https://www.gnu.org/software/bash/manual/bash.html#index-PROMPT_005fCOMMAND
PROMPT_COMMAND='__prompt_command'
