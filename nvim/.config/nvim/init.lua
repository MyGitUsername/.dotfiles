-- Lazy.nvim plugin manager
-- see ~/.config/nvim/lua/plugins.lua
-- see ~/.config/nvim/lua/config/lazy.lua
require("config.lazy")

------------------------------
--General Nvim Customization--
------------------------------
-- Spaces and Tabs
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2     -- the number of spaces <TAB> character counts for when editing a file
vim.opt.expandtab = true    -- tabs are spaces (e.g., <TAB> is a shortcut for add four spaces)

vim.opt.relativenumber = true

vim.opt.lazyredraw = true         -- redraw the screen only when required
vim.opt.showmatch = true          -- highlights matching parenthesis-like character when cursor is hovered over one
vim.opt.wrap = false

vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode with jj' })
vim.keymap.set('i', ';;', '<Esc>', { desc = 'Exit insert mode with ;;' })

vim.opt.incsearch = true          -- search as characters are entered
vim.opt.hlsearch = true

-- turn off search highlight with <leader><space>
vim.keymap.set('n', '<leader><space>', ':nohlsearch<CR>', { desc = 'Clear search highlight' })

vim.opt.scrolloff = 8

-- Set leader key early
vim.g.mapleader = ','  

-- Colorscheme Config 
vim.cmd[[colorscheme tokyonight-moon]]

-- Git Gutter
vim.cmd('highlight clear SignColumn')

-- Lualine Config
vim.opt.cmdheight = 0 -- Hide neovim command line area when not in use
require('lualine').setup {
  options = {
    theme = 'auto',
  },
  tabline = {
    lualine_a = {
      {
        'buffers',
        mode = 2, -- Shows buffer name + index number
      }
    },
    lualine_z = {'tabs'}
  }
}

for i = 1, 9 do
  vim.keymap.set('n', '<leader>' .. i, '<Cmd>LualineBuffersJump ' .. i .. '<CR>')
end

-- FZF-Lua
vim.keymap.set("n", "<leader>ff", "<cmd>FzfLua files<cr>")
vim.keymap.set("n", "<leader>fgr", "<cmd>FzfLua live_grep<cr>")
vim.keymap.set("n", "<leader>fb", "<cmd>FzfLua buffers<cr>")
vim.keymap.set("n", "<leader>fh", "<cmd>FzfLua help_tags<cr>")
vim.keymap.set("n", "<leader>fgs", "<cmd>FzfLua git_status<cr>")
vim.keymap.set("n", "<leader>fgf", "<cmd>FzfLua git_files<cr>")

require("mason").setup()
require("mason-lspconfig").setup()
local nvim_lsp = require('lspconfig')

local capabilities = require('cmp_nvim_lsp').default_capabilities()

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
  vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)

end

-- Typescript: tsserver
-- Ruby: solargraph, sorbet

local servers = { "solargraph", "elixirls" }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

nvim_lsp.solargraph.setup {
  cmd = {"solargraph", "stdio"},
  filetypes = { "ruby" },
  init_options = {
    formatting = true
  },
  root_dir = require("lspconfig.util").root_pattern("Gemfile", ".git"),
  settings = {
    solargraph = {
      diagnostics = true
    }
  }
}
-- https://www.mitchellhanberg.com/how-to-set-up-neovim-for-elixir-development/
 -- /home/michael/.local/share/nvim/lsp_servers/elixir/elixir-ls/language_server.sh" },
nvim_lsp.elixirls.setup {
  cmd = { "/home/michael/.local/share/nvim/mason/bin/elixir-ls" },
  capabilities = capabilities,
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
--[[
nvim_lsp.tsserver.setup {
    cmd = { "/home/michael/.local/share/nvim/lsp_servers/tsserver/node_modules/.bin/typescript-language-server" };
}
nvim_lsp.sorbet.setup {
    cmd = { "/home/michael/.local/share/nvim/lsp_servers/sorbet/bin/srb", "--lsp" };
}
nvim_lsp.pyright.setup {
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
    autocmd TextYankPost * silent! lua vim.hl.on_yank()
  augroup end
]],
  false
)

require'nvim-treesitter.configs'.setup {
  -- A list of parser names, or "all"
  ensure_installed = { "elixir", "heex", "lua" },

  highlight = {
    -- `false` will disable the whole extension
    enable = true,
  },
}
