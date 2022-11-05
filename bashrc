#   -------------------------------
#   ENVIRONMENT CONFIGURATION
#   -------------------------------

#   Set Paths
#   ------------------------------------------------------------
    export PATH="/usr/local/bin:/usr/local/sbin:$HOME/bin:$PATH"

#   Set Variables for NVM (node) for Homebrew
#   ------------------------------------------------------------
    export NVM_DIR="$HOME/.nvm"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
    [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion
    
#   Set global Node Options
#   ------------------------------------------------------------
    export NODE_OPTIONS=--max_old_space_size=4096
    
#   Set Variables for Ruby Gems for Homebrew
#   ------------------------------------------------------------
    export GEM_HOME="/usr/local/Cellar/gems"
    export GEM_PATH="/usr/local/Cellar/gems/gems"
    
#   Load RVM into a shell session *as a function*
#   ------------------------------------------------------------
    [[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
    
#   Set python virtual environment auto-activation
#   ------------------------------------------------------------
    export PYENV_VIRTUALENV_DISABLE_PROMPT=1
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    export PATH="$PYENV_ROOT/shims:$PATH"
    if which pyenv > /dev/null; then  eval "$(pyenv init -)"; fi
    if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi
    
#   Load phpbrew initialization
#   ------------------------------------------------------------
    [[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc
    
#   Set GDAL and GEOS Path for Django 1.11
#   Source: https://www.alextomkins.com/2017/08/fixing-gdal-geos-django-macos/
#   ------------------------------------------------------------
    export GDAL_LIBRARY_PATH="/Library/Frameworks/GDAL.framework/Versions/2.1/GDAL"
    export GEOS_LIBRARY_PATH="/Library/Frameworks/GEOS.framework/Versions/3/GEOS"
    
#   Set Android SDK Root and PATH
#   ------------------------------------------------------------
    export ANDROID_SDK_ROOT="/usr/local/share/android-sdk"
    [[ -L "$ANDROID_SDK_ROOT" && -d "$ANDROID_SDK_ROOT" ]] && export ANDROID_HOME=$ANDROID_SDK_ROOT
    
#   Set Composer Memory Limit to Unlimited
#   ------------------------------------------------------------
    COMPOSER_MEMORY_LIMIT=-1

    # Work Path for fast website dev environment switching
    CDPATH=.:~/work/webcakes

#   Set XDG Spec for OSX
#   ------------------------------------------------------------
    export XDG_CONFIG_HOME="$HOME/.config"
    export XDG_CACHE_HOME="$HOME/.cache"
    export XDG_DATA_HOME="$HOME/.local/share"

#   Check for promptline.vim shell script output and source it if it exists
#   ------------------------------------------------------------
    if [ -f ~/.shell_prompt.sh ]; then
      source ~/.shell_prompt.sh
    fi

#   Check for brew bash_completion and add it if it exists
#   ------------------------------------------------------------
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
      . $(brew --prefix)/etc/bash_completion
    fi

#   Set Default Editor (default is 'nano')
#   ------------------------------------------------------------
    export EDITOR=vim

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

#   Initialize phpbrew config
#   ------------------------------------------------------------
    [[ -e ~/.phpbrew/bashrc ]] && source ~/.phpbrew/bashrc

#   Change iTerm2 tab title
#   Source: https://gist.github.com/phette23/5270658#gistcomment-2765858
#   ------------------------------------------------------------
#   if [[ $ITERM_SESSION_ID ]]; then
#     # Display the current git repo, or directory, in iterm tabs.
#     get_iterm_label() {
#       if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
#         local directory
#         directory=${PWD##*/}
#         echo -ne "\\033];$directory\\007"
#       else
#         local branch
#         local branchdir
#         branchdir=$(basename "$(git rev-parse --show-toplevel)")
#         branch=$(git branch 2>/dev/null | grep -e '\* ' | sed "s/^..\(.*\)/{\1}/")
#         echo -ne "\\033];$branchdir $branch\\007"
#       fi
#     }
#     export PROMPT_COMMAND=get_iterm_label;"${PROMPT_COMMAND}"
#   fi

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

alias cp='cp -iv'                                      # Preferred 'cp' implementation
alias mv='mv -iv'                                      # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                                # Preferred 'mkdir' implementation
alias ll='ls -FGlAhp'                                  # Preferred 'ls' implementation
alias less='less -FSRXc'                               # Preferred 'less' implementation
cdl() { builtin cd "$@"; ll; }                         # List directory contents upon 'cd'
alias pd='cd -'                                        # Go back to the previous PATH
alias cd..='cd ../'                                    # Go back 1 directory level (for fast typers)
alias ..='cd ../'                                      # Go back 1 directory level
alias ...='cd ../../'                                  # Go back 2 directory levels
alias ..3='cd ../../../'                               # Go back 3 directory levels
alias ..4='cd ../../../../'                            # Go back 4 directory levels
alias ..5='cd ../../../../../'                         # Go back 5 directory levels
alias ..6='cd ../../../../../../'                      # Go back 6 directory levels
alias edit='mvim'                                      # edit: Opens any file in MacVim editor
alias ~="cd ~"                                         # ~: Go Home
alias c='clear'                                        # c: Clear terminal display
alias which='type -all'                                # which: Find executables
alias path='echo -e ${PATH//:/\\n}'                    # path: Echo all executable Paths
alias show_options='shopt'                             # Show_options: display bash options settings
alias fix_stty='stty sane'                             # fix_stty: Restore terminal settings when screwed up
alias cic='set completion-ignore-case On'              # cic: Make tab-completion case-insensitive
mcd () { mkdir -p "$1" && cd "$1"; }                   # mcd: Makes new Dir and jumps inside
alias work="cd ~/work/"                                # work: Changes to the work directory
DOTFILESPATH="~/.dotfiles"
alias dotfiles="cd $DOTFILESPATH/"                     # dotfiles: Changes to the dotfiles directory
alias config="cd $XDG_CONFIG_HOME"                     # config: Changes to the directory that contains configs (usually $XDG_CONFIG_HOME)
alias profile="open $DOTFILESPATH/profile"             # profile: Opens Terminal login's config file in the default editor
alias bashrc="open $DOTFILESPATH/bashrc"               # bashrc: Opens bash's config file in the default editor
alias vimrc="open $DOTFILESPATH/vimrc"                 # vimrc: Opens Vim's config file in the default editor
alias nvimrc="open $DOTFILESPATH/config/nvim/init.vim" # nvimrc: Opens NeoVim's Init.vim config file in the default editor
alias gitconfig="open $DOTFILESPATH/gitconfig"         # gitconfig: Opens git's config file in the default editor

#   -----------------------------
#   Docker Functions
#   Source: https://gist.github.com/jgrodziski/9ed4a17709baad10dbcd4530b60dfcbb
#   ------------------------------------------------------------

function dnames-fn {
	for ID in `docker ps | awk '{print $1}' | grep -v 'CONTAINER'`
	do
    	docker inspect $ID | grep Name | head -1 | awk '{print $2}' | sed 's/,//g' | sed 's%/%%g' | sed 's/"//g'
	done
}

function dip-fn {
    echo "IP addresses of all named running containers"

    for DOC in `dnames-fn`
    do
        IP=`docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}} {{end}}' "$DOC"`
        OUT+=$DOC'\t'$IP'\n'
    done
    echo -e $OUT | column -t
    unset OUT
}

function dex-fn {
	docker exec -it $1 ${2:-bash}
}

function di-fn {
	docker inspect $1
}

function dl-fn {
	docker logs -f $1
}

function drun-fn {
	docker run -it $1 $2
}

function dcr-fn {
	docker-compose run $@
}

function dsr-fn {
	docker stop $1;docker rm $1
}

function drmc-fn {
  docker rm $(docker ps --all -q -f status=exited)
}

function drmid-fn {
  imgs=$(docker images -q -f dangling=true)
  [ ! -z "$imgs" ] && docker rmi "$imgs" || echo "no dangling images."
}

# in order to do things like dex $(dlab label) sh
function dlab {
  docker ps --filter="label=$1" --format="{{.ID}}"
}

function dc-fn {
  docker-compose $*
}

function d-aws-cli-fn {
  docker run \
         -e AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID \
         -e AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION \
         -e AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY \
         amazon/aws-cli:latest $1 $2 $3
}

alias daws=d-aws-cli-fn
alias dc=dc-fn
alias dcu="docker-compose up -d"
alias dcub="docker-compose up -d --build"
alias dcd="docker-compose down"
alias dcr=dcr-fn
alias dex=dex-fn
alias di=di-fn
alias dim="docker images"
alias dip=dip-fn
alias dl=dl-fn
alias dnames=dnames-fn
alias dps="docker ps"
alias dpsa="docker ps -a"
alias drmc=drmc-fn
alias drmid=drmid-fn
alias drun=drun-fn
alias dsp="docker system prune --all"
alias dsr=dsr-fn

#   -------------------------------
#   FILE AND FOLDER MANAGEMENT
#   -------------------------------
zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder
alias numFiles='echo $(ls -1 | wc -l)'      # numFiles:     Count of non-hidden files in current dir
alias make1mb='mkfile 1m ./1MB.dat'         # make1mb:      Creates a file of 1mb size (all zeros)
alias make5mb='mkfile 5m ./5MB.dat'         # make5mb:      Creates a file of 5mb size (all zeros)
alias make10mb='mkfile 10m ./10MB.dat'      # make10mb:     Creates a file of 10mb size (all zeros)

#   cdf:  'Cd's to frontmost window of MacOS Finder
#   ------------------------------------------------------
    cdf () {
        currFolderPath=$( /usr/bin/osascript <<"    EOT"
            tell application "Finder"
                try
            set currFolder to (folder of the front window as alias)
                on error
            set currFolder to (path to desktop folder as alias)
                end try
                POSIX path of currFolder
            end tell
        EOT
        )
        echo "cd to \"$currFolderPath\""
        cd "$currFolderPath"
    }
    
#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
    extract () {
        if [ -f $1 ] ; then
          case $1 in
            *.tar.bz2)   tar xjf $1     ;;
            *.tar.gz)    tar xzf $1     ;;
            *.bz2)       bunzip2 $1     ;;
            *.rar)       unrar e $1     ;;
            *.gz)        gunzip $1      ;;
            *.tar)       tar xf $1      ;;
            *.tbz2)      tar xjf $1     ;;
            *.tgz)       tar xzf $1     ;;
            *.zip)       unzip $1       ;;
            *.Z)         uncompress $1  ;;
            *.7z)        7z x $1        ;;
            *)     echo "'$1' cannot be extracted via extract()" ;;
             esac
         else
             echo "'$1' is not a valid file"
         fi
    }
    
#   ---------------------------
#   SEARCHING
#   ---------------------------
alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string
#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
    spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }
    
#   ---------------------------
#   PROCESS MANAGEMENT
#   ---------------------------
#   findPid: find out the pid of a specified process
#   -----------------------------------------------------
#       Note that the command name can be specified via a regex
#       E.g. findPid '/d$/' finds pids of all processes with names ending in 'd'
#       Without the 'sudo' it will only find processes of the current user
#   -----------------------------------------------------
    findPid () { lsof -t -c "$@" ; }
    
#   memHogsTop, memHogsPs:  Find memory hogs
#   -----------------------------------------------------
    alias memHogsTop='top -l 1 -o rsize | head -20'
    alias memHogsPs='ps wwaxm -o pid,stat,vsize,rss,time,command | head -10'
    
#   cpuHogs:  Find CPU hogs
#   -----------------------------------------------------
    alias cpu_hogs='ps wwaxr -o pid,stat,%cpu,time,command | head -10'
    
#   topForever:  Continual 'top' listing (every 10 seconds)
#   -----------------------------------------------------
    alias topForever='top -l 9999999 -s 10 -o cpu'
#   ttop:  Recommended 'top' invocation to minimize resources
#   ------------------------------------------------------------
#       Taken from this macosxhints article
#       http://www.macosxhints.com/article.php?story=20060816123853639
#   ------------------------------------------------------------
    alias ttop="top -R -F -s 10 -o rsize"
    
#   my_ps: List processes owned by my user:
#   ------------------------------------------------------------
    my_ps() { ps $@ -u $USER -o pid,%cpu,%mem,start,time,bsdtime,command ; }
#   ---------------------------
#   NETWORKING
#   ---------------------------
alias myip='curl ip.appspot.com'                    # myip:         Public facing IP Address
alias netCons='lsof -i'                             # netCons:      Show all open TCP/IP sockets
alias flushDNS='dscacheutil -flushcache'            # flushDNS:     Flush out the DNS Cache
alias lsock='sudo /usr/sbin/lsof -i -P'             # lsock:        Display open sockets
alias lsockU='sudo /usr/sbin/lsof -nP | grep UDP'   # lsockU:       Display only open UDP sockets
alias lsockT='sudo /usr/sbin/lsof -nP | grep TCP'   # lsockT:       Display only open TCP sockets
alias ipInfo0='ipconfig getpacket en0'              # ipInfo0:      Get info on connections for en0
alias ipInfo1='ipconfig getpacket en1'              # ipInfo1:      Get info on connections for en1
alias openPorts='sudo lsof -i | grep LISTEN'        # openPorts:    All listening connections
alias showBlocked='sudo ipfw list'                  # showBlocked:  All ipfw rules inc/ blocked IPs
#   ii:  display useful host related informaton
#   -------------------------------------------------------------------
    ii() {
        echo -e "\nYou are logged on ${RED}$HOST"
        echo -e "\nAdditionnal information:$NC " ; uname -a
        echo -e "\n${RED}Users logged on:$NC " ; w -h
        echo -e "\n${RED}Current date :$NC " ; date
        echo -e "\n${RED}Machine stats :$NC " ; uptime
        echo -e "\n${RED}Current network location :$NC " ; scselect
        echo -e "\n${RED}Public facing IP Address :$NC " ;myip
        #echo -e "\n${RED}DNS Configuration:$NC " ; scutil --dns
        echo
    }
    
#   ---------------------------------------
#   SYSTEMS OPERATIONS & INFORMATION
#   ---------------------------------------
alias mountReadWrite='/sbin/mount -uw /'    # mountReadWrite:   For use when booted into single-user
#   cleanupDS:  Recursively delete .DS_Store files
#   -------------------------------------------------------------------
    alias cleanupDS="find . -type f -name '*.DS_Store' -ls -delete"
    
#   finderShowHidden:   Show hidden files in Finder
#   finderHideHidden:   Hide hidden files in Finder
#   -------------------------------------------------------------------
    alias finderShowHidden='defaults write com.apple.finder ShowAllFiles TRUE'
    alias finderHideHidden='defaults write com.apple.finder ShowAllFiles FALSE'
    
#   cleanupLS:  Clean up LaunchServices to remove duplicates in the "Open With" menu
#   -----------------------------------------------------------------------------------
    alias cleanupLS="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister -kill -r -domain local -domain system -domain user && killall Finder"
    
#    screensaverDesktop: Run a screensaver on the Desktop
#   -----------------------------------------------------------------------------------
    alias screensaverDesktop='/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine -background'
    
#   ---------------------------------------
#   WEB DEVELOPMENT
#   ---------------------------------------
alias apacheEdit='sudo edit /etc/httpd/httpd.conf'      # apacheEdit:       Edit httpd.conf
alias apacheRestart='sudo apachectl graceful'           # apacheRestart:    Restart Apache
alias editHosts='sudo edit /etc/hosts'                  # editHosts:        Edit /etc/hosts file
alias herr='tail /var/log/httpd/error_log'              # herr:             Tails HTTP error logs
alias apacheLogs="less +F /var/log/apache2/error_log"   # Apachelogs:   Shows apache error logs
httpHeaders () { /usr/bin/curl -I -L $@ ; }             # httpHeaders:      Grabs headers from web page
#   httpDebug:  Download a web page and show info on what took time
#   -------------------------------------------------------------------
    httpDebug () { /usr/bin/curl $@ -o /dev/null -w "dns: %{time_namelookup} connect: %{time_connect} pretransfer: %{time_pretransfer} starttransfer: %{time_starttransfer} total: %{time_total}\n" ; }
    
#   ---------------------------------------
#   REMINDERS & NOTES
#   ---------------------------------------
#   remove_disk: spin down unneeded disk
#   ---------------------------------------
#   diskutil eject /dev/disk1s3
#   to change the password on an encrypted disk image:
#   ---------------------------------------
#   hdiutil chpass /path/to/the/diskimage
#   to mount a read-only disk image as read-write:
#   ---------------------------------------
#   hdiutil attach example.dmg -shadow /tmp/example.shadow -noverify
#   mounting a removable drive (of type msdos or hfs)
#   ---------------------------------------
#   mkdir /Volumes/Foo
#   ls /dev/disk*   to find out the device to use in the mount command)
#   mount -t msdos /dev/disk1s1 /Volumes/Foo
#   mount -t hfs /dev/disk1s1 /Volumes/Foo
#   to create a file of a given size: /usr/sbin/mkfile or /usr/bin/hdiutil
#   ---------------------------------------
#   e.g.: mkfile 10m 10MB.dat
#   e.g.: hdiutil create -size 10m 10MB.dmg
#   the above create files that are almost all zeros - if random bytes are desired
#   then use: ~/Dev/Perl/randBytes 1048576 > 10MB.dat