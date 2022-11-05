#   -----------------------------
#   TERMINAL (MacOS) SPECIFIC ALIASES
#   -----------------------------
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
ql () { qlmanage -p "$*" >& /dev/null; }    # ql:           Opens any file in MacOS Quicklook Preview
alias DT='tee ~/Desktop/terminalOut.txt'    # DT:           Pipe content to file on MacOS Desktop
alias f='open -a Finder ./'                 # f:            Opens current directory in MacOS Finder

#   -----------------------------
#   FUNCTIONS
#   -----------------------------
#   Git Functions
#   ------------------------------------------------------------
# GIT USER PROFILE SETTING / SWITCHING
# This will strip the current static User from the current repo and Include an external User profile.
# This function relies on: Git, A Git Repo, a config file located in ~/config/git/profilename.user.config
# Format must be profilename.user.config
# Usage: gituser home => ~/config/git/home.user.config
# Usage: gituser "Work GitHub" => ~/config/git/Work Github.user.config
gituser() {
  # Set the directory where these configs exist
  configdir="$HOME/.config/git"
  # Sanity check
  if [ -z "$(which git)" ]
  then
    echo "Error: git binary not found" >&2
    return 255
  fi
  # Check if the directory has a git repo
  if [ -z "$(git status)" ]
  then
    echo "Error: Current directory does not contain a git repository (or any of the parent directories): .git" >&2
    return 255
  fi
  # Check for the config file
  if [ ! -e "$configdir/$1.user.config" ]
  then
    echo "Error: '$1.user.config' not found in: $configdir" >&2
    return 255
  fi
  # Remove current static User Name and Email for the repo
  if [ -n "$(git config --local user.name)" ] || [ -n "$(git config --local user.email)" ]
  then
    username="$(git config --local user.name)"
    useremail="$(git config --local user.email)"
    git config --local --unset-all user
    git config --local --remove-section user
    echo "User's Name: $username has been removed."
    echo "User's Email: $useremail has been removed."
  fi
  # Time to include the user profile!
  git config include.path "$configdir/$1.user.config"
  echo "User Profile: $1.user.config has been included."
  return 0
}