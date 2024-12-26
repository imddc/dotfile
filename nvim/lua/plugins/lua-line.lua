return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  opts = function(_, opts)
    return {
      --[[add your custom lualine config here]]
      --
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      }),
    }
  end,
}
