Plugin Manager
```sh
git clone https://github.com/tmux-plugins/tpm ${XDG_CONFIG_HOME}/tmux/plugins/tpm
```
Plugins are recommended to install by the means of the TPM

Add to the tmux.conf
```
set -g @plugin tmux-plugins/tmux-sensible
set -g @plugin tmux-plugins/tmux-resurrect
set -g @plugin tmux-plugins/tmux-continuum

set -g @plugin catppuccin/tmux#v2.1.2
```

See [plugin's list](https://github.com/tmux-plugins/tmux-sensible) for more
