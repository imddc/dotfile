return {
  'neovim/nvim-lspconfig',
  -- 'b0o/schemastore.nvim',
  servers = {
    eslint = {
      settings = {
        workingDirectories = { mode = 'auto' },
      },
    },
  },
  inlay_hints = {
    enabled = true,
  },
  codelens = {
    enabled = false,
  },
  config = function()
    local lspconfig = require 'lspconfig'

    -- graphql
    lspconfig.graphql.setup {
      filetypes = {
        'graphql',
        'gql',
      },
    }

    -- lua
    lspconfig.lua_ls.setup {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    }

    lspconfig.html.setup {}
    lspconfig.cssls.setup {}

    -- tailwind
    lspconfig.tailwindcss.setup {
      color_square_width = 2,
    }

    -- volar 只管vue ts-tools 负责全部js/ts
    lspconfig.volar.setup {
      filetypes = {
        'vue',
      },
      init_options = {
        vue = {
          hybridMode = false,
        },
      },
    }

    -- prisma
    lspconfig.prismals.setup {}
    lspconfig.dockerls.setup {}
    lspconfig.jsonls.setup {}
  end,
}
