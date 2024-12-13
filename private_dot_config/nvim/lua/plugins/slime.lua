return {
  {
    "jpalardy/vim-slime",
    init = function()
      -- these two should be set before the plugin loads
      vim.g.slime_target = "neovim"
      vim.g.slime_no_mappings = true
    end,
    config = function()
      vim.g.slime_input_pid = false
      vim.g.slime_suggest_default = true
      vim.g.slime_menu_config = false
      vim.g.slime_neovim_ignore_unlisted = false
      vim.g.slime_cell_delimiter = "# %% *$"
      vim.g.slime_cell_delimiter_type = "regex"
      vim.g.slime_python_ipython = 1
      -- options not set here are g:slime_neovim_menu_order, g:slime_neovim_menu_delimiter, and g:slime_get_jobid
      -- see the documentation above to learn about those options

      -- called MotionSend but works with textobjects as well
      -- vim.keymap.set("n", "gz", "<Plug>SlimeMotionSend", { remap = true, silent = false })
      -- vim.keymap.set("n", "gzz", "<Plug>SlimeLineSend", { remap = true, silent = false })
      -- vim.keymap.set("x", "gz", "<Plug>SlimeRegionSend", { remap = true, silent = false })
      -- vim.keymap.set("no", "gzc", "<Plug>SlimeConfig", { remap = true, silent = false })
      vim.keymap.set("n", "<localleader>cc", "<Plug>SlimeSendCell", { noremap = true, silent = false })
      vim.keymap.set("n", "<localleader>cv", "<cmd>SlimeConfig<CR>", { noremap = true, silent = false })
      vim.keymap.set(
        "n",
        "<localleader>ck",
        "<cmd>lua require('slime').prev_cell()<CR>",
        { noremap = true, silent = false }
      )
      vim.keymap.set(
        "n",
        "<localleader>cj",
        "<cmd>lua require('slime').next_cell()<CR>",
        { noremap = true, silent = false }
      )
      vim.keymap.set("n", "<localleader>cl", "<cmd>SlimeLineSend<CR>", { noremap = true, silent = false })
      vim.keymap.set("x", "<localleader>e", "<Plug>SlimeRegionSend", { noremap = true, silent = false })
    end,
    -- keys = {
    --   { "n", "<localleader>cc", "<Plug>SlimeSendCell", { noremap = true, desc = "Send cell to slime" } },
    --   { "n", "<localleader>cv", "<cmd>SlimeConfig<CR>", { noremap = true, desc = "Open slime configuration" } },
    --   {
    --     "n",
    --     "<localleader>ck",
    --     "<cmd>lua require('slime').prev_cell()<CR>",
    --     { noremap = true, desc = "Search backward for slime cell delimiter" },
    --   },
    --   {
    --     "n",
    --     "<localleader>cj",
    --     "<cmd>lua require('slime').next_cell()<CR>",
    --     { noremap = true, desc = "Search forward for slime cell delimiter" },
    --   },
    --   { "x", "<localleader>e", "<Plug>SlimeRegionSend", { noremap = true, desc = "send line to tmux" } },
    --   -- { "n", "<leader>ep", "<Plug>SlimeParagraphSend", { noremap = true, desc = "Send Paragraph with Slime" } },
    -- },
  },
}
