typeset -U path # don't add duplicate entries to path

#export PATH=/snap/bin:$HOME/.rbenv/bin:$HOME/.local/share/nvim/lsp_servers/python/node_modules/.bin:$HOME/.local/share/nvim/lsp_servers/sorbet/bin:$HOME/npm-global/bin:$HOME/.gem/ruby/2.7.0/bin:$PATH
fpath=(
  ~/snap/bin 
  ~/.rbenv/bin 
  ~/.local/share/nvim/lsp_servers/python/node_modules/.bin
  ~/.local/share/nvim/lsp_servers/sorbet/bin
  ~/npm-global/bin
  ~/.gem/ruby/2.7.0/bin
  ~/.zsh.d/ 
  $fpath
)

path=(~/.rbenv/bin $path)

# Set important shell env variables
export EDITOR=vim                 # Set default editor
export TERM="rxvt-unicode-256color"
export BAT_THEME="Solarized (dark)"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix --hidden --exclude .git'
# You can preview the content of the file under the cursor by setting --preview option.
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
# The following example uses tree command to show the entries of the directory.
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
