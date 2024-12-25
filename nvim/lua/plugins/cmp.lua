-- check if in start tag
local function is_in_start_tag()
  local ts_utils = require("nvim-treesitter.ts_utils")
  local node = ts_utils.get_node_at_cursor()
  if not node then
    return false
  end
  local node_to_check = { "start_tag", "self_closing_tag", "directive_attribute" }
  return vim.tbl_contains(node_to_check, node:type())
end

return {
  "hrsh7th/nvim-cmp",
  opts = function(_, opts)
    local cmp = require("cmp")
    opts = vim.tbl_deep_extend("force", opts or {}, {
      -- vue 组件 cmp增强
      sources = cmp.config.sources({
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

  entry_filter = function(entry, ctx)
    -- Use a buffer-local variable to cache the result of the Treesitter check
    local bufnr = ctx.bufnr
    local cached_is_in_start_tag = vim.b[bufnr]._vue_ts_cached_is_in_start_tag
    if cached_is_in_start_tag == nil then
      vim.b[bufnr]._vue_ts_cached_is_in_start_tag = is_in_start_tag()
    end
    -- If not in start tag, return true
    if vim.b[bufnr]._vue_ts_cached_is_in_start_tag == false then
      return true
    end
    -- rest of the code
  end,
}
