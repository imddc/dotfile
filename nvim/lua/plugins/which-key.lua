return {
  "folke/which-key.nvim",
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
    -- lazyGit
    {
      "<leader>lz",
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
    {
      -- telescpe search
      "<leader>.",
      "<cmd>Telescope live_grep<cr>",
      desc = "搜索关键字 ctrl+shift+f",
    },
    {
      -- telescpe search
      "<leader>td",
      "<cmd>TodoTelescope<cr>",
      desc = "todoTelescope",
    },
  },
}
