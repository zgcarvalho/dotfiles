require('plugins')

-- local colorbuddy = require('colorbuddy')
-- colorbuddy.colorscheme('gruvbox-material')
vim.api.nvim_command('colorscheme OceanicNext')

local lualine = require('lualine')
lualine.setup({
  options = {
    theme = 'oceanicnext',
  },
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {'encoding', 'fileformat', 'filetype'},
    lualine_y = {'progress'},
    lualine_z = {'location'}
  },
})

local neogit = require('neogit')
neogit.setup {}

local on_attach = function(_client, bufnr)
  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  require('completion').on_attach(client)

  local opts = { noremap=true, silent=true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
end

local lspconfig = require('lspconfig')
lspconfig.rust_analyzer.setup({
    on_attach=on_attach,
    settings = {
        ["rust-analyzer"] = {
            assist = {
                importMergeBehavior = "last",
                importPrefix = "by_self",
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
        }
    }
})
--[[ lspconfig.jedi_language_server.setup({
    on_attach=on_attach,
}) ]]
lspconfig.pyright.setup({
    on_attach=on_attach,
})
lspconfig.texlab.setup({
    on_attach=on_attach,
})


vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    virtual_text = true,
    signs = true,
    update_in_insert = true,
  }
)

local lsp_ext = require('lsp_extensions')
lsp_ext.inlay_hints({ only_current_line = false })

local treesitter_config = require('nvim-treesitter.configs')
treesitter_config.setup({
  highlight = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<C-n>",
      node_incremental = "<C-n>",
      scope_incremental = "<C-s>",
      node_decremental = "<C-r>",
    },
  },
  indent = {
    enable = true
  },
})

-- latex config
-- local vimtex = require('vimtex')
conceallevel = 1
-- vimtex.conceallevel = 1
-- vim.g.tex_conceal = 'abdmg'
-- vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0
vim.g.matchup_override_vimtex = 1


-- snippets config
--[[ vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>' ]]

--- vim:sw=2 fdm=marker
--- Type za to toggle one fold or zi to toggle 'foldenable'. See :help fold-commands for more info.
-- local api, fn, cmd = vim.api, vim.fn, vim.cmd
--- {{{1 [[ OPTIONS ]]
vim.o.termguicolors = true
vim.wo.number = true
vim.wo.signcolumn = 'yes' -- Display signs in the number column
vim.wo.foldmethod = 'expr'
vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
vim.wo.list = true
vim.wo.linebreak = true
vim.wo.breakindent = true
vim.o.showmode = false
vim.o.pumblend = 10
vim.g.vimsyn_embed = 'l' -- Highlight Lua code inside .vim files

vim.o.expandtab = true; vim.bo.expandtab = true
vim.o.shiftwidth = 2; vim.bo.shiftwidth = 2
vim.o.tabstop = 2; vim.bo.tabstop = 2

vim.o.inccommand = 'split'

-- I'm used to text editors opening side panels to the right of/below the current one
vim.o.splitright = true
vim.o.splitbelow = true

-- This sets up prettier as the default formatter. It has good defaults for common filetypes.
-- Can be overridden with a buffer-local option
vim.o.formatprg = 'prettier --stdin-filepath=%'

vim.o.mouse = 'a'
-- CursorHold autocmds are dependent on updatetime. The default is 4000, which is too long for many things
vim.o.updatetime = 300
vim.o.hidden = true
vim.o.undofile = true; vim.bo.undofile = true -- Persistent undo is a neat feature
vim.o.shortmess = vim.o.shortmess .. 'cI' -- No startup screen, no ins-completion-menu messages
vim.o.completeopt = 'menuone,noinsert,noselect' -- Required for nvim-compe

-- mappings
