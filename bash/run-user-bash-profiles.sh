# run profiles under ~/.config/bash/profile.d/
BASH_PROFILE_DIRECTORY="${HOME}/.config/bash/profile.d"
if [ -d "${BASH_PROFILE_DIRECTORY}" ]; then
    for bash_profile in $(echo "${BASH_PROFILE_DIRECTORY}"/*); do
        test -f "${bash_profile}" && . "${bash_profile}"
    done
fi
