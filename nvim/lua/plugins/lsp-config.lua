return {
  'neovim/nvim-lspconfig',
  dependencies = {
    'b0o/schemastore.nvim',
  },
  opts = {
    -- inlay_hints = { enabled = true },
  },
  servers = {
    eslint = {
      settings = {
        workingDirectories = { mode = 'auto' },
      },
    },
  },
  codelens = {
    enabled = false,
  },
  config = function()
    local lspconfig = require 'lspconfig'

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities.textDocument.completion.completionItem.snippetSupport = true

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
        -- 'typescript',
        -- 'javascript',
        -- 'typescriptreact',
        -- 'javascriptreact',
        'vue',
      },
    }
    -- No need to set `hybridMode` to `true` as it's the default value
    lspconfig.volar.setup {}

    lspconfig.eslint.setup {
      on_attach = function(client, bufnr)
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          command = 'EslintFixAll',
        })
      end,
      filetypes = {
        'javascript',
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'vue',
      },
    }

    -- html
    lspconfig.html.setup { capabilities = capabilities, filetypes = { 'html' } }
    -- css
    lspconfig.cssls.setup {
      capabilities = capabilities,
      filetypes = { 'css', 'scss', 'less', 'sass' },
    }

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
