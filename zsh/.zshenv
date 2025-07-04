typeset -U path # don't add duplicate entries to path

# TODO: fix rbenv, fzf, z tab complete
# https://stackoverflow.com/questions/25290751/where-to-place-zsh-autocompletion-script-on-linux
fpath=(
  ~/.dotfiles/zsh/functions/completion
  $fpath
)

path=(
  # ~/.rbenv/bin
  ~/.local/share/gem/ruby/3.1.0/bin/solargraph
  $path
)

# Set important shell env variables
export EDITOR=vim                 # Set default editor
export BAT_THEME="Solarized (dark)"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --exclude .git'
# You can preview the content of the file under the cursor by setting --preview option.
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# The following example uses tree command to show the entries of the directory.
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
export LIVEBOOK_PASSWORD="testpasswordthirty"

