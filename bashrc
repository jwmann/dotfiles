#   -------------------------------
#   ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Set Paths
#   ------------------------------------------------------------
    export PATH="/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH"

    # Work Path for fast website dev environment switching
    CDPATH=.:~/work/webcakes

#   Set XDG Spec for OSX
#   ------------------------------------------------------------
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"

#   Set Default Editor (default is 'nano')
#   ------------------------------------------------------------
    export EDITOR=vim

    # Set vimrc's location and source it on vim startup
    export MYVIMRC="$XDG_CONFIG_HOME/vim/vimrc"
    export VIMINIT='source $MYVIMRC'

#   Set Default ReadLine (default is 'emacs')
#   ------------------------------------------------------------
    set -o vi

#   Avoid succesive duplicates in the bash command history.
#   ------------------------------------------------------------
    export HISTCONTROL=ignoredups

#   Set default blocksize for ls, df, du
#   from this: http://hints.macworld.com/comment.php?mode=view&cid=24491
#   ------------------------------------------------------------
    export BLOCKSIZE=1k

#   Add color/color variables to terminal
#   (this is all commented out as I use Mac Terminal Profiles)
#   from http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
#   ------------------------------------------------------------
#   export CLICOLOR=1
#   export LSCOLORS=ExFxBxDxCxegedabagacad
    RED="\[\033[0;31m\]"
    BOLDRED="\[\033[1;31m\]"
    YELLOW="\[\033[0;33m\]"
    GREEN="\[\033[0;32m\]"
    WHITE="\[\033[0;37m\]"

#   Change Prompt
#   ------------------------------------------------------------
    export PS1="$GREEN\w$WHITE\$(git branch 2>/dev/null | grep -e '\* ' | sed 's/^..\(.*\)/$YELLOW {\1}$WHITE/') \$ "



#   lr:  Full Recursive Directory Listing
#   ------------------------------------------
alias lr='ls -R | grep ":$" | sed -e '\''s/:$//'\'' -e '\''s/[^-][^\/]*\//--/g'\'' -e '\''s/^/   /'\'' -e '\''s/-/|/'\'' | less'

#   mans:   Search manpage given in agument '1' for term given in argument '2' (case insensitive)
#           displays paginated result with colored search terms and two lines surrounding each hit.             Example: mans mplayer codec
#   --------------------------------------------------------------------
    mans () {
        man $1 | grep -iC2 --color=always $2 | less
    }

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
    showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }


#   -----------------------------
#   BASH ALIASES
#   -----------------------------

alias cp='cp -iv'                               # Preferred 'cp' implementation
alias mv='mv -iv'                               # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                         # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                           # Preferred 'ls' implementation
alias less='less -FSRXc'                        # Preferred 'less' implementation
cdl() { builtin cd "$@"; ll; }                  # List directory contents upon 'cd'
alias pd='cd -'                                 # Go back to the previous PATH
alias cd..='cd ../'                             # Go back 1 directory level (for fast typers)
alias ..='cd ../'                               # Go back 1 directory level
alias ...='cd ../../'                           # Go back 2 directory levels
alias ..3='cd ../../../'                        # Go back 3 directory levels
alias ..4='cd ../../../../'                     # Go back 4 directory levels
alias ..5='cd ../../../../../'                  # Go back 5 directory levels
alias ..6='cd ../../../../../../'               # Go back 6 directory levels
alias edit='mvim'                               # edit: Opens any file in MacVim editor
alias ~="cd ~"                                  # ~: Go Home
alias c='clear'                                 # c: Clear terminal display
alias which='type -all'                         # which: Find executables
alias path='echo -e ${PATH//:/\\n}'             # path: Echo all executable Paths
alias show_options='shopt'                      # Show_options: display bash options settings
alias fix_stty='stty sane'                      # fix_stty: Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'       # cic: Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }            # mcd: Makes new Dir and jumps inside
alias dotfiles='cd ~/.dotfiles/'                # dotfiles: Changes to the dotfiles directory
alias config='cd ~/.config/'                    # config: Changes to the directory that contains configs (usually $XDG_CONFIG_HOME)
alias profile='open ~/.dotfiles/profile'        # profile: Opens Terminal login's config file in the default editor
alias bashrc='open ~/.dotfiles/bashrc'          # bashrc: Opens bash's config file in the default editor
alias vimrc='open ~/.dotfiles/config/vim/vimrc' # vimrc: Opens Vim's config file in the default editor
alias gitconfig='open ~/.dotfiles/gitconfig'    # gitconfig: Opens git's config file in the default editor
