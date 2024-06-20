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

    -- -- graphql
    -- lspconfig.graphql.setup {
    --   filetypes = {
    --     'graphql',
    --     'gql',
    --   },
    -- }

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

    lspconfig.tsserver.setup {
      filetypes = {
        'vue',
      },
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = '/path/to/@vue/language-server',
            languages = { 'vue' },
          },
        },
      },
    }

    lspconfig.volar.setup {
      init_options = {
        vue = {
          hybridMode = false,
        },
      },
    }

    -- No need to set `hybridMode` to `true` as it's the default value
    local mason_registry = require 'mason-registry'
    local vue_language_server_path = mason_registry
      .get_package('vue-language-server')
      :get_install_path() .. '/node_modules/@vue/language-server'
    lspconfig.tsserver.setup {
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue' },
          },
        },
      },
      filetypes = {
        -- 'typescript',
        -- 'javascript',
        -- 'javascriptreact',
        -- 'typescriptreact',
        'vue',
      },
    }
    -- No need to set `hybridMode` to `true` as it's the default value
    lspconfig.volar.setup {}

    -- html
    lspconfig.html.setup {}
    -- css
    lspconfig.cssls.setup {}

    -- emmet
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true
    lspconfig.emmet_ls.setup {
      -- on_attach = on_attach,
      capabilities = capabilities,
      filetypes = {
        'css',
        'eruby',
        'html',
        'javascript',
        'javascriptreact',
        'less',
        'sass',
        'scss',
        'svelte',
        'pug',
        'typescriptreact',
        'vue',
      },
      init_options = {
        html = {
          options = {
            -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
            ['bem.enabled'] = true,
          },
        },
      },
    }

    -- tailwind
    lspconfig.tailwindcss.setup {
      color_square_width = 2,
    }

    -- prisma
    lspconfig.prismals.setup {}

    -- docker
    lspconfig.dockerls.setup {}

    -- jsonsl
    lspconfig.jsonls.setup {}
  end,
}
