return {
  "rafamadriz/friendly-snippets",
  depends = {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  setup = function()
    require("luasnip.loaders.from_vscode").lazy_load({
      "LuaSnip",
    })
  end,
}
