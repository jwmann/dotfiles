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

- `.profile` is for things that are not specifically related to Bash, like environment variables $PATH and friends, and should be available anytime. For example, `.profile` should also be loaded when starting a graphical desktop session.

- `.bashrc` is for the configuring the interactive Bash usage, like Bash aliases, setting your favorite editor, setting the Bash prompt, etc.

- `.bash_profile` is for making sure that both the things in `.profile` and `.bashrc` are loaded for login shells.

Custom command: `gituser`  
This command looks for 'config' files within `~/config/git/`  
A file named this `work.user.config` can be included into the current git repo's config by doing `gituser work`.  
This allows you to change various config setting per repo easily depending on the context. ( e.g.: Work, Personal, School, etc.. )

#### Bash Setup Sources

1. http://natelandau.com/my-mac-osx-bash_profile
2. http://stefaanlippens.net/bashrc_and_others

[1]: https://github.com/thoughtbot/rcm 
[2]: https://github.com/junegunn/vim-plug
