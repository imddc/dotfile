return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'b0o/schemastore.nvim',
  },
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

    -- No need to set `hybridMode` to `true` as it's the default value
    local mason_registry = require 'mason-registry'
    local vue_language_server_path = mason_registry
      .get_package('vue-language-server')
      :get_install_path() .. '/node_modules/@vue/language-server'
    lspconfig.tsserver.setup {
      -- on_attach = function(client, bufnr)
      --   -- 禁用 tsserver 的格式化功能，我们将使用 ESLint 来格式化代码
      --   client.resolved_capabilities.document_formatting = false
      -- end,
      init_options = {
        plugins = {
          {
            name = '@vue/typescript-plugin',
            location = vue_language_server_path,
            languages = { 'vue', 'javascript', 'typescript' },
          },
        },
      },
      filetypes = {
        'typescript',
        'javascript',
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
    lspconfig.jsonls.setup {
      capabilities = require('cmp_nvim_lsp').default_capabilities(
        vim.lsp.protocol.make_client_capabilities()
      ),

      settings = {
        json = {
          schemas = require('schemastore').json.schemas {
            replace = {
              ['package.json'] = {
                description = 'package.json overridden',
                fileMatch = { 'package.json' },
                name = 'package.json',
                url = 'https://json.schemastore.org/package.json',
              },
            },
          },
          validate = { enable = true },
        },
      },
    }
  end,
}
