return {
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-buffer', -- source for text in buffer
    'hrsh7th/cmp-path', -- source for file system paths
    'L3MON4D3/LuaSnip', -- snippet engine
    'hrsh7th/cmp-cmdline',
    'saadparwaiz1/cmp_luasnip', -- for autocompletion
    'onsails/lspkind.nvim', -- vs-code like pictograms
  },
  config = function()
    local cmp = require 'cmp'
    local luasnip = require 'luasnip'
    local lspkind = require 'lspkind'

    cmp.setup {
      completion = {
        completeopt = 'menu,menuone,preview,noselect',
      },
      formatting = {
        format = lspkind.cmp_format {
          maxwidth = 51,
          ellipsis_char = '...',
        },
      },
      snippet = { -- configure how nvim-cmp interacts with snippet engine
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      mapping = cmp.mapping.preset.insert {
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
      },
      sources = cmp.config.sources({
        { name = 'luasnip' }, -- For luasnip users.
        { name = 'crates' },
        { name = 'nvim_lsp', priority = 1000, group_index = 1 },
        { name = 'buffer', priority = 500, group_index = 2 },
        { name = 'snippets', priority = 750, group_index = 1 },
        { name = 'path', priority = 250, group_index = 1 },
        { name = 'calc', priority = 100 },
        { name = 'emoji', priority = 150 },
      }, {
        { name = 'buffer' },
      }),
      window = {
        completion = cmp.config.window.bordered {
          border = {
            { '󱐋', 'WarningMsg' },
            { '─', 'Comment' },
            { '╮', 'Comment' },
            { '│', 'Comment' },
            { '╯', 'Comment' },
            { '─', 'Comment' },
            { '╰', 'Comment' },
            { '│', 'Comment' },
          },
        },
        documentation = cmp.config.window.bordered {
          border = {
            { '', 'DiagnosticHint' },
            { '─', 'Comment' },
            { '╮', 'Comment' },
            { '│', 'Comment' },
            { '╯', 'Comment' },
            { '─', 'Comment' },
            { '╰', 'Comment' },
            { '│', 'Comment' },
          },
        },
      },
    }

    -- Set configuration for specific filetype.
    cmp.setup.filetype('gitcommit', {
      sources = cmp.config.sources({
        { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
        { name = 'buffer' },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ '/', '?' }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = 'buffer' },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(':', {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = 'path' },
      }, {
        { name = 'cmdline' },
      }),
    })

    -- snippets
    require('luasnip.loaders.from_vscode').load {
      paths = { '~/.config/nvim/snippets' },
    }
  end,
}

-- return {
--   -- {
--   --   'hrsh7th/nvim-cmp',
--   --   dependencies = {
--   --     'hrsh7th/cmp-emoji',
--   --     'hrsh7th/cmp-calc',
--   --   },
--   --   opts = function(_, opts)
--   --     table.insert(opts.sources, { name = 'emoji' })
--   --     table.insert(opts.sources, { name = 'calc' })
--   --   end,
--   -- },
--   {
--     'hrsh7th/nvim-cmp',
--     dependencies = {
--       'hrsh7th/cmp-nvim-lsp',
--       'hrsh7th/cmp-buffer',
--       'hrsh7th/cmp-path',
--       'saadparwaiz1/cmp_luasnip',
--       'hrsh7th/cmp-emoji',
--       'hrsh7th/cmp-calc',
--     },
--     opts = function(_, opts)
--       opts.sources = {
--         { name = 'nvim_lsp', priority = 1000, group_index = 1 },
--         { name = 'buffer', priority = 500, group_index = 2 },
--         { name = 'luasnip', priority = 750, group_index = 1 },
--         { name = 'path', priority = 250, group_index = 1 },
--         { name = 'calc', priority = 100 },
--         { name = 'emoji', priority = 150 },
--       }
--     end,
--   },
--   {
--     'hrsh7th/nvim-cmp',
--     dependencies = {
--       'nvim-tree/nvim-web-devicons',
--       'onsails/lspkind.nvim',
--     },
--     opts = function(_, opts)
--       local cmp = require 'cmp'
--       local lspkind = require 'lspkind'
--       opts = vim.tbl_deep_extend('force', opts or {}, {
--         sources = {
--           { name = 'nvim_lsp', priority = 1000, group_index = 1 },
--           { name = 'buffer', priority = 500, group_index = 2 },
--           { name = 'snippets', priority = 750, group_index = 1 },
--           { name = 'path', priority = 250, group_index = 1 },
--           { name = 'calc', priority = 100 },
--           { name = 'emoji', priority = 150 },
--         },
--         window = {
--           completion = cmp.config.window.bordered {
--             border = {
--               { '󱐋', 'WarningMsg' },
--               { '─', 'Comment' },
--               { '╮', 'Comment' },
--               { '│', 'Comment' },
--               { '╯', 'Comment' },
--               { '─', 'Comment' },
--               { '╰', 'Comment' },
--               { '│', 'Comment' },
--             },
--           },
--           documentation = cmp.config.window.bordered {
--             border = {
--               { '', 'DiagnosticHint' },
--               { '─', 'Comment' },
--               { '╮', 'Comment' },
--               { '│', 'Comment' },
--               { '╯', 'Comment' },
--               { '─', 'Comment' },
--               { '╰', 'Comment' },
--               { '│', 'Comment' },
--             },
--           },
--         },
--         preselect = cmp.PreselectMode.None,
--         completion = {
--           keyword_length = 1,
--           completeopt = 'menu,menuone,noinsert,noselect',
--         },
--         formatting = {
--           fields = { 'kind', 'abbr', 'menu' },
--           format = lspkind.cmp_format {
--             mode = 'symbol_text',
--             preset = 'codicons',
--             before = function(entry, vim_item)
--               if vim.tbl_contains({ 'path' }, entry.source.name) then
--                 local icon, hl_group = require('nvim-web-devicons').get_icon(
--                   entry:get_completion_item().label
--                 )
--                 if icon then
--                   vim_item.kind = icon
--                   vim_item.kind_hl_group = hl_group
--                   return vim_item
--                 end
--               end
--               vim_item.menu = ({
--                 nvim_lsp = '(LSP)',
--                 buffer = '(Buffer)',
--                 path = '(Path)',
--                 snippets = '(Snippet)',
--                 emoji = '(Emoji)',
--                 calc = '(Calc)',
--               })[entry.source.name]
--
--               vim_item.dup = ({
--                 buffer = 1,
--                 path = 1,
--                 nvim_lsp = 0,
--                 snippets = 1,
--               })[entry.source.name] or 0
--               return vim_item
--             end,
--           },
--         },
--       })
--       return opts
--     end,
--   },
--   {
--     'hrsh7th/nvim-cmp',
--     keys = { ':', '/', '?' },
--     dependencies = {
--       'hrsh7th/cmp-cmdline',
--     },
--     config = function(_, opts)
--       local cmp = require 'cmp'
--
--       cmp.setup(opts)
--       cmp.setup.cmdline('/', {
--         mapping = cmp.mapping.preset.cmdline(),
--         sources = {
--           { name = 'buffer' },
--         },
--       })
--       cmp.setup.cmdline(':', {
--         mapping = cmp.mapping.preset.cmdline(),
--         sources = cmp.config.sources({
--           { name = 'path' },
--         }, {
--           {
--             name = 'cmdline',
--             option = {
--               ignore_cmds = { 'Man', '!' },
--             },
--           },
--         }),
--       })
--     end,
--   },
-- }
