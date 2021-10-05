-- Install packer
local execute = vim.api.nvim_command

local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com/wbthomason/packer.nvim '.. install_path)
end

vim.api.nvim_exec([[
  augroup Packer
    autocmd!
    autocmd BufWritePost plugins.lua PackerCompile
  augroup end
]], false)

local use = require('packer').use
require('packer').startup(function()
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use 'nvim-lua/lsp_extensions.nvim'
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
  }
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  -- use 'nvim-lua/completion-nvim'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/nvim-cmp'
  use 'hrsh7th/cmp-vsnip'
  use 'hrsh7th/vim-vsnip'
  use { 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' }
  use 'b3nj5m1n/kommentary'
  -- snippets
  -- use 'sirver/ultisnips'
  -- use 'honza/vim-snippets'

  -- latex
  use {'lervag/vimtex', ft = 'tex', opt = true}
  -- use 'vigoux/LanguageTool.nvim'
  use "rhysd/vim-grammarous" 
  -- use 'lervag/vimtex'
  -- Markdown
  -- use 'iamcco/markdown-preview.nvim'
  --[[ use {'iamcco/markdown-preview.nvim',
    run = 'cd app && yarn install',
    cmd = 'MarkdownPreview',
    ft = {'markdown', 'markdown.pandoc'}}  ]]
  use 'vim-pandoc/vim-pandoc-syntax'
  --

  -- colorscheme
  use 'tjdevries/colorbuddy.nvim'
  use 'maaslalani/nordbuddy'
  use 'Th3Whit3Wolf/onebuddy'
  use 'sainnhe/gruvbox-material'
  -- use 'tjdevries/gruvbuddy.nvim'
  use 'rockerBOO/boo-colorscheme-nvim'
  use 'mhartington/oceanic-next'
end)
