local cmp = require("cmp")
-- check if in start tag

return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-calc",
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "calc" })
      table.insert(opts.sources, { name = "emoji" })

      opts = vim.tbl_deep_extend("force", opts or {}, {
        -- vue 组件 cmp增强
        sources = cmp.config.sources({
          { name = "copilot", priority = 1000, group_index = 1 },
          {
            name = "nvim_lsp",
            ---@param entry cmp.Entry
            ---@param ctx cmp.Context
            entry_filter = function(entry, ctx)
              -- Check if the buffer type is 'vue'
              if ctx.filetype ~= "vue" then
                return true
              end

              local cursor_before_line = ctx.cursor_before_line
              -- For events
              if cursor_before_line:sub(-1) == "@" then
                return entry.completion_item.label:match("^@")
              -- For props also exclude events with `:on-` prefix
              elseif cursor_before_line:sub(-1) == ":" then
                return entry.completion_item.label:match("^:") and not entry.completion_item.label:match("^:on%-")
              else
                return true
              end
            end,
            priority = 1000,
            group_index = 1,
          },
          { name = "buffer", priority = 500, group_index = 2 },
          { name = "luasnip", priority = 750, group_index = 1 },
          { name = "path", priority = 250, group_index = 1 },
          { name = "calc", priority = 100 },
        }),
        window = {
          completion = cmp.config.window.bordered({
            border = {
              { "󱐋", "WarningMsg" },
              { "─", "Comment" },
              { "╮", "Comment" },
              { "│", "Comment" },
              { "╯", "Comment" },
              { "─", "Comment" },
              { "╰", "Comment" },
              { "│", "Comment" },
            },
          }),
          documentation = cmp.config.window.bordered({
            border = {
              { "", "DiagnosticHint" },
              { "─", "Comment" },
              { "╮", "Comment" },
              { "│", "Comment" },
              { "╯", "Comment" },
              { "─", "Comment" },
              { "╰", "Comment" },
              { "│", "Comment" },
            },
          }),
        },
        preselect = cmp.PreselectMode.None,
        completion = {
          keyword_length = 1,
          completeopt = "menu,menuone,noinsert,noselect",
        },
        -- formatting = {
        --   format = function(_, item)
        --     local icon = LazyVim.config.icons.kinds[item.kind]
        --     if LazyVim.has("mini.icons") then
        --       local mini_icon, _, _ = require("mini.icons").get("lsp", item.kind)
        --       if mini_icon then
        --         icon = mini_icon .. " "
        --       end
        --     end
        --
        --     if icon then
        --       item.kind = icon .. item.kind
        --     end
        --
        --     return item
        --   end,
        -- },
      })
      return opts
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    keys = { ":", "/", "?" },
    dependencies = {
      "hrsh7th/cmp-cmdline",
    },
    config = function(_, opts)
      cmp.setup(opts)
      cmp.setup.cmdline("/", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = "buffer" },
        },
      })
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          {
            name = "cmdline",
            option = {
              ignore_cmds = { "Man", "!" },
            },
          },
        }),
      })
    end,
  },
}
