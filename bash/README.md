With this directory as working directory:
```shell
mkdir -p \
    ~/.config/bash/ \
    ~/.config/bash/profile.d

ln -s \
    "${PWD}/run-user-bash-profiles.sh" \
    ~/.config/bash/

ln -s \
    "${PWD}/prompt.sh" \
    "${PWD}/aliases.sh" \
    ~/.config/bash/profile.d/

echo 'source ~/.config/bash/run-user-bash-profiles.sh' >> ~/.bashrc
```

Optional, but may be desired
```shell
# Let login shell having interactive shell's settings.
# NOTE: Some distro skip .bashrc when there's a .bash_profile.
echo 'test -f ~/.bashrc && source ~/.bashrc' >> ~/.bash_profile

touch ~/.config/bash/profile.d/local-environment-variables.sh
echo 'export LANG=en_US.UTF-8' >> ~/.config/bash/profile.d/local-environment-variables.sh
```
