-- Example init.lua
-- https://github.com/mjlbach/defaults.nvim/blob/master/init.lua

-- Install packer
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.api.nvim_exec(
  [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]],
  false
)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim' -- Package manager
  use 'neovim/nvim-lspconfig' -- Collection of configurations for built-in LSP client
  use 'williamboman/nvim-lsp-installer' -- Install LSP servers locally with :LspInstall
  use 'altercation/vim-colors-solarized' -- Solarized colorscheme
  use 'sheerun/vim-polyglot' -- Collection of language packs
  use 'tpope/vim-commentary'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'hrsh7th/nvim-cmp' -- Autocompletion plugin
  use 'hrsh7th/cmp-nvim-lsp' -- LSP source for nvim-cmp
  use 'saadparwaiz1/cmp_luasnip' -- Snippets source for nvim-cmp
  use 'L3MON4D3/LuaSnip' -- Snippets plugin
  use {
    'nvim-telescope/telescope.nvim',
    requires = { {'nvim-lua/plenary.nvim'} }
  }
  use { 'kyazdani42/nvim-web-devicons' } -- Icons for telescope
  use { 'airblade/vim-gitgutter' }
  use { 'github/copilot.vim' }
end)

-- Refactor to lua
vim.cmd [[
  " Airline
  let g:airline#extensions#tabline#enabled = 1
  let g:airline#extensions#tabline#buffer_idx_mode = 1
  let mapleader = ','
  nmap <leader>1 <Plug>AirlineSelectTab1
  nmap <leader>2 <Plug>AirlineSelectTab2
  nmap <leader>3 <Plug>AirlineSelectTab3
  nmap <leader>4 <Plug>AirlineSelectTab4
  nmap <leader>5 <Plug>AirlineSelectTab5
  nmap <leader>6 <Plug>AirlineSelectTab6
  nmap <leader>7 <Plug>AirlineSelectTab7
  nmap <leader>8 <Plug>AirlineSelectTab8
  nmap <leader>9 <Plug>AirlineSelectTab9
  nmap <leader>0 <Plug>AirlineSelectTab0

  " Telescope
  let mapleader = ','
  nnoremap <leader>ff <cmd>Telescope find_files<cr>
  nnoremap <leader>fgr <cmd>Telescope live_grep<cr>
  nnoremap <leader>fb <cmd>Telescope buffers<cr> 
  nnoremap <leader>fh <cmd>Telescope help_tags<cr>
  nnoremap <leader>fgs <cmd>Telescope git_status<cr>
  nnoremap <leader>fgf <cmd>Telescope git_files<cr>

  " Git Gutter
  highlight clear SignColumn

  " Colorscheme
  set background=dark
  syntax enable
  colorscheme solarized

  " Spaces and Tabs
  set shiftwidth=2
  set softtabstop=2     " the number of spaces <TAB> character counts for when editing a file
  set expandtab        " tabs are spaces (e.g., <TAB> is a shortcut for add four spaces)

  " Turn hybrid line numbers on
  set number relativenumber

  " filetype indent on      " turns on language detection and allows loading of language specific indentation
  " (e.g., loads python indentation that lives in ~/.vim/indent/python.vim)
  filetype plugin on      " loads typescript config that lives in ~/.vim/after/ftplugin/ts.vim
  " set wildmenu         " provides graphical menu for when autocompletion is triggered
  set lazyredraw        " redraw the screen only when required
  set showmatch         " highlights matching parenthesis-like character when cursor is hovered over one

  set nowrap
  " jj key is <Esc> setting
  inoremap jj <Esc>
  inoremap ;; <Esc>

  " Searching
  set incsearch " search as characters are entered
  set hlsearch
  nnoremap <leader><space> :nohlsearch<CR> " turn off search highlight with <SPACE>

  set scrolloff=8
]]

local nvim_lsp = require('lspconfig')

-- Add additional capabilities supported by nvim-cmp
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

-- Mappings.
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  --Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)

end

-- Typescript: tsserver
-- Ruby: solargraph, sorbet

--[[
local servers = { "tsserver", "sorbet", "pyright", "elixirls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

require'lspconfig'.tsserver.setup {
    cmd = { "/home/michael/.local/share/nvim/lsp_servers/tsserver/node_modules/.bin/typescript-language-server" };
}
-- https://www.mitchellhanberg.com/how-to-set-up-neovim-for-elixir-development/
require'lspconfig'.elixirls.setup {
  cmd = { "/home/michael/.local/share/nvim/lsp_servers/elixir/elixir-ls/language_server.sh" },
  -- capabilities = capabilities,
  on_attach = on_attach,
  settings = {
    elixirLS = {
      -- I choose to disable dialyzer for personal reasons, but
      -- I would suggest you also disable it unless you are well
      -- aquainted with dialzyer and know how to use it.
      dialyzerEnabled = false,
      -- I also choose to turn off the auto dep fetching feature.
      -- It often get's into a weird state that requires deleting
      -- the .elixir_ls directory and restarting your editor.
      fetchDeps = false
    }
  }
}
require'lspconfig'.sorbet.setup {
    cmd = { "/home/michael/.local/share/nvim/lsp_servers/sorbet/bin/srb", "--lsp" };
}
require'lspconfig'.pyright.setup {
    cmd = { "/home/michael/.local/share/nvim/lsp_servers/python/node_modules/.bin/pyright-langserver",  "--stdio"};
}
--]]


-- luasnip setup
local luasnip = require 'luasnip'

-- nvim-cmp setup
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-expand-or-jump', true, true, true), '')
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        vim.fn.feedkeys(vim.api.nvim_replace_termcodes('<Plug>luasnip-jump-prev', true, true, true), '')
      else
        fallback()
      end
    end,
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

-- Highlight on yank
vim.api.nvim_exec(
  [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]],
  false
)
