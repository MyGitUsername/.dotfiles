# source z script
. /opt/homebrew/etc/profile.d/z.sh

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Rbenv
eval "$(rbenv init -)"

# Pyenv
eval "$(pyenv init -)"

# Vi-mode in the cmd line
set -o vi

# History
HISTSIZE=100000                 # The max number of commands that are loaded into memory from the history file
SAVEHIST=100000                  # The max number of commands that are stored in the zsh history file
HISTFILE=~/.zsh_history

setopt HIST_FIND_NO_DUPS         # Stepping through your history will not show duplicates.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.
setopt HIST_VERIFY               # Don't execute immediately upon history expansion.

source $HOME/.aliases
source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme

# Path
export PATH=$PATH:/Users/mkmac/.gem/ruby/2.7.0/bin

##############
##### FZF ####
##############

# fh - repeat history
fh() {
  eval $( ([ -n "$ZSH_NAME" ] && fc -l 1 || history) | fzf +s --tac | sed -E 's/ *[0-9]*\*? *//' | sed -E 's/\\/\\\\/g')
}

fcd() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
      -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fkill - kill processes - list only the ones you can kill. Modified the earlier script.
fkill() {
  local pid
  if [ "$UID" != "0" ]; then
    pid=$(ps -f -u $UID | sed 1d | fzf -m | awk '{print $2}')
  else
    pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')
  fi

  if [ "x$pid" != "x" ]
  then
    echo $pid | xargs kill -${1:-9}
  fi
}

# fs [FUZZY PATTERN] - Select selected tmux session
# #   - Bypass fuzzy finder if there's only one match (--select-1)
# #   - Exit if there's no match (--exit-0)
fs() {
  local session
  session=$(tmux list-sessions -F "#{session_name}" | \
    fzf --query="$1" --select-1 --exit-0) &&
    tmux switch-client -t "$session"
  }

# ftpane - switch pane (@george-b)
ftpane() {
  local panes current_window current_pane target target_window target_pane
  panes=$(tmux list-panes -s -F '#I:#P - #{pane_current_path} #{pane_current_command}')
  current_pane=$(tmux display-message -p '#I:#P')
  current_window=$(tmux display-message -p '#I')

  target=$(echo "$panes" | grep -v "$current_pane" | fzf +m --reverse) || return

  target_window=$(echo $target | awk 'BEGIN{FS=":|-"} {print$1}')
  target_pane=$(echo $target | awk 'BEGIN{FS=":|-"} {print$2}' | cut -c 1)

  if [[ $current_window -eq $target_window ]]; then
    tmux select-pane -t ${target_window}.${target_pane}
  else
    tmux select-pane -t ${target_window}.${target_pane} &&
      tmux select-window -t $target_window
  fi
}

# TODO: tweak to use relative path
fgd() {
  git diff $(git diff --name-only | fzf)
}

# docker
dpsf() {
  docker ps --format "table {{.Names}}\t{{.Status}}\t{{.State}}"
}
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
