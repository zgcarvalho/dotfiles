-- plugins/quarto.lua
return {
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      codeRunner = {
        enabled = true,
        default_method = "slime",
      },
    },
    init = function()
      local runner = require("quarto.runner")
      vim.keymap.set("n", "<localleader>rc", runner.run_cell, { desc = "run cell", silent = true })
      vim.keymap.set("n", "<localleader>ra", runner.run_above, { desc = "run cell and above", silent = true })
      vim.keymap.set("n", "<localleader>rA", runner.run_all, { desc = "run all cells", silent = true })
      vim.keymap.set("n", "<localleader>rl", runner.run_line, { desc = "run line", silent = true })
      vim.keymap.set("v", "<localleader>r", runner.run_range, { desc = "run visual range", silent = true })
      vim.keymap.set("n", "<localleader>RA", function()
        runner.run_all(true)
      end, { desc = "run all cells of all languages", silent = true })
    end,
    config = function()
      vim.o.conceallevel = 0
    end,
  },
}
--
-- return {
--   {
--     dir = "/home/zgcarvalho/study/neovim/quarto-nvim", -- substitua pelo caminho real
--     dev = true,
--     dependencies = {
--       "jmbuhr/otter.nvim",
--       "nvim-treesitter/nvim-treesitter",
--       "Olical/conjure",
--     },
--     config = function()
--       require("quarto").setup({
--         codeRunner = {
--           enabled = true,
--           default_method = "conjure",
--           ft_runners = {
--             python = "conjure",
--             r = "conjure",
--             julia = "conjure",
--           },
--         },
--         keymap = {
--           run_cell = {
--             normal = "<C-CR>",
--             insert = "<C-CR>",
--           },
--         },
--       })
--     end,
--   },
--   {
--     "Olical/conjure",
--     ft = { "python", "r", "julia" },
--     config = function()
--       vim.g["conjure#mapping#prefix"] = "<leader>c"
--       vim.g["conjure#client#python#stdio#command"] = "python"
--     end,
--   },
-- }
