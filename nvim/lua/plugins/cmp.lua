return {
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")
      opts = vim.tbl_deep_extend("force", opts or {}, {
        sources = cmp.config.sources({
          -- volar
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
          },
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
        formatting = {
          format = function(_, item)
            local icon = LazyVim.config.icons.kinds[item.kind]
            if LazyVim.has("mini.icons") then
              local mini_icon, _, _ = require("mini.icons").get("lsp", item.kind)
              if mini_icon then
                icon = mini_icon .. " "
              end
            end

            if icon then
              item.kind = icon .. item.kind
            end

            return item
          end,
        },
      })
      return opts
    end,
  },
}
