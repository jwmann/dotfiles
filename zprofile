emulate sh
source ~/.profile
emulate zsh

# Set PATH, MANPATH, etc., for Homebrew.
eval "$(/opt/homebrew/bin/brew shellenv)"

# Add avr-gcc@8 to path for qmk
export PATH="/opt/homebrew/opt/avr-gcc@8/bin:$PATH"

# Added by Obsidian for Obsidian CLI
export PATH="$PATH:/Applications/Obsidian.app/Contents/MacOS"

# Cursor Movement Bindings
bindkey "[D" backward-word
bindkey "[C" forward-word
bindkey "^[a" beginning-of-line
bindkey "^[e" end-of-line
