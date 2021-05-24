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

--[[ local neogit = require('neogit')
neogit.setup {} ]]

local on_attach = function(client)
    require('completion').on_attach(client)
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
-- vimtex.conceallevel = 1
--[[ vim.g.tex_conceal = 'abdmg'
vim.g.tex_flavor = 'latex'
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_quickfix_mode = 0 ]]

-- snippets config
--[[ vim.g.UltiSnipsExpandTrigger = '<tab>'
vim.g.UltiSnipsJumpForwardTrigger = '<tab>'
vim.g.UltiSnipsJumpBackwardTrigger = '<s-tab>' ]]

--- vim:sw=2 fdm=marker
--- Type za to toggle one fold or zi to toggle 'foldenable'. See :help fold-commands for more info.
local api, fn, cmd = vim.api, vim.fn, vim.cmd
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
local map = api.nvim_set_keymap
-- vim.g.mapleader = ' '

--[[ --- {{{1 [[ LSPCONFIG
local function custom_lsp_attach(client, bufnr)
  local cap = client.resolved_capabilities

  --- Mappings
  local function bmap(mode, lhs, rhs)
    api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, {noremap = true})
  end

  bmap('n', ']E', '<Cmd>lua vim.lsp.diagnostic.goto_next()<CR>')
  bmap('n', '[E', '<Cmd>lua vim.lsp.diagnostic.goto_prev()<CR>')
  bmap('n', 'gl', '<Cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
  if cap.goto_definition then
    bmap('n', '<C-]>', '<Cmd>lua vim.lsp.buf.definition()<CR>')
  end
  if cap.hover then
    bmap('n', 'K', '<Cmd>lua vim.lsp.buf.hover()<CR>')
  end
  if cap.code_action then
    bmap('n', 'gA', '<Cmd>lua vim.lsp.buf.code_action()<CR>')
    bmap('x', 'gA', '<Cmd>lua vim.lsp.buf.range_code_action()<CR>')
  end

  --- Commands
  if cap.rename then
    cmd 'command! -buffer -nargs=? LspRename lua vim.lsp.buf.rename(<f-args>)'
  end
  if cap.find_references then
    cmd 'command! -buffer LspReferences lua vim.lsp.buf.references()'
  end
  if cap.workspace_symbol then
    cmd 'command! -buffer -nargs=? LspWorkspaceSymbol lua vim.lsp.buf.workspace_symbol(<f-args>)'
  end
  if cap.call_hierarchy then
    cmd 'command! -buffer LspIncomingCalls lua vim.lsp.buf.incoming_calls()'
    cmd 'command! -buffer LspOutgoingCalls lua vim.lsp.buf.outgoing_calls()'
  end
  if cap.workspace_folder_properties.supported then
    cmd 'command! -buffer LspListWorkspaceFolders lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))'
    cmd 'command! -buffer -nargs=? -complete=dir LspAddWorkspaceFolder lua vim.lsp.buf.add_workspace_folder(<f-args>)'
    cmd 'command! -buffer -nargs=? -complete=dir LspRemoveWorkspaceFolder lua vim.lsp.buf.remove_workspace_folder(<f-args>)'
  end
  if cap.document_symbol then
    cmd 'command! -buffer LspDocumentSymbol lua vim.lsp.buf.document_symbol()'
  end
  if cap.goto_definition then
    cmd 'command! -buffer LspDefinition lua vim.lsp.buf.definition()'
  end
  if cap.type_definition then
    cmd 'command! -buffer LspTypeDefinition lua vim.lsp.buf.type_definition()'
  end
  if cap.declaration then
    cmd 'command! -buffer LspDeclaration lua vim.lsp.buf.declaration()'
  end
  if cap.implementation then
    cmd 'command! -buffer LspImplementation lua vim.lsp.buf.implementation()'
  end
end ]]
