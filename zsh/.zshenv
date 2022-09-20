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

