# dotfiles / rc's

Some of my dotfiles made public, managed via [rcm][1].

### Install

1. Install rcm via homebrew.

```
$ brew tap thoughtbot/formulae
$ brew install rcm
```

2. Clone this repository into your $HOME.

```
$ git clone git@github.com:jwmann/dotfiles.git ~/.dotfiles
```

3. Link up dotfiles using `rcup`.

```
$ rcup -v
```

## Sections & Info

### New host setup

Setting up a new machine?
Run this initalization script for common homebrew apps

[brew-init][https://gist.github.com/jwmann/db1b4d900c1de8a695118c6279a95d11]

### Configs

Sync common configs outside of this repo from NAS
Make sure to Sync the Drive and make 'home/AppPrefs/config' available offline

```
$ ln -s ~/Library/CloudStorage/SynologyDrive-home/AppPrefs/config/* ~/.config/
```

### Vim

My Vim setup utilizes [vim-plug][2] as a Plugin Manager.
My `.vimrc` is setup to automatically download [vim-plug][2] should it not exist for some reason.
Run [vim-plug][2]'s `:PlugInstall` command within Vim to setup plugins.

---

### Git

Various useful aliases and configs.
Specifically not including a default editor as to rely on the terminal's set default editor.

---

### Bash

Various useful aliases and configs.

- `.bashrc` is for the configuring the interactive Bash usage, like Bash aliases, setting your favorite editor, setting the Bash prompt, etc.

- `.bash_profile` is for making sure that both the things in `.profile` and `.bashrc` are loaded for login shells.

---

### Profile

- `.profile` is for things that are not specifically related to Bash, like environment variables $PATH and functions, and should be available anytime. For example, `.profile` should also be loaded when starting a graphical desktop session.

Custom command: `gituser`  
This command looks for 'config' files within `~/config/git/`  
A file named this `work.user.config` can be included into the current git repo's config by doing `gituser work`.  
This allows you to change various config setting per repo easily depending on the context. ( e.g.: Work, Personal, School, etc.. )

---

#### Setup Sources & Quick Links

1. [oh-my-zsh - Wiki](https://github.com/ohmyzsh/ohmyzsh/wiki)
2. [oh-my-zsh - Plugins](https://github.com/ohmyzsh/ohmyzsh/tree/master/plugins)
3. http://natelandau.com/my-mac-osx-bash_profile
4. http://stefaanlippens.net/bashrc_and_others
5. [Generating new SSH keys](https://docs.github.com/en/authentication/connecting-to-github-with-ssh/generating-a-new-ssh-key-and-adding-it-to-the-ssh-agent)

[1]: https://github.com/thoughtbot/rcm
[2]: https://github.com/junegunn/vim-plug
