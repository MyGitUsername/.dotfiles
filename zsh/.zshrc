# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# Set important shell env variables
export EDITOR=vim                 # Set default editor


# Load external config files and tools
source $HOME/.aliases
source $HOME/.functions
source $HOME/.git-fzf
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh # To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
source /opt/homebrew/etc/profile.d/z.sh
eval "$(rbenv init -)" # Rbenv
eval "$(pyenv init -)" # Pyenv


# Path
export PATH=$PATH:/Users/mkmac/.gem/ruby/2.7.0/bin


# Misc
setopt vi                         # Enable vi-mode
bindkey -M viins 'jj' vi-cmd-mode # Enter vi mode with jj
setopt NO_BEEP                    # Disable beeps
setopt AUTO_CD                    # Sends cd commands without the need for 'cd'


# ZSH History
HISTSIZE=100000                  # The max number of commands that are loaded into memory from the history file
SAVEHIST=100000                  # The max number of commands that are stored in the zsh history file
HISTFILE=~/.zsh_history
setopt HIST_FIND_NO_DUPS         # Stepping through your history will not show duplicates.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.


# Use modern completion system
autoload -Uz compinit
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' menu select=2
# eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'
zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true

zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'
