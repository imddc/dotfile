return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
  },
  keys = {
    -- {
    --   "<leader>?",
    --   function()
    --     require("which-key").show({ global = false })
    --   end,
    --   desc = "Buffer Local Keymaps (which-key)",
    -- },
    -- neotree
    {
      "<c-;>",
      "<cmd>Neotree focus<cr>",
      desc = "Neotree focus",
    },
    {
      "<leader>:",
      "<cmd>Neotree focus<cr>",
      desc = "Neotree focus",
    },
    -- lazyGit
    {
      "<leader>lg",
      "<cmd>LazyGit<cr>",
      desc = "Open LazyGit",
    },
    -- yazi
    {
      "<leader>yz",
      "<cmd>Yazi<cr>",
      desc = "Open yazi at the current file",
    },
    {
      -- Open in the current working directory
      "<leader>cw",
      "<cmd>Yazi cwd<cr>",
      desc = "Open the file manager in nvim's working directory",
    },
  },
}
