return {
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'b0o/schemastore.nvim',
    },
    opts = {
      inlay_hints = {
        enabled = true,
        exclude = {
          'typescriptreact',
          'javascriptreact',
          'javascript',
          'typescript',
          'vue',
        },
      },
      codelens = {
        enabled = false,
      },
      servers = {
        biome = {
          settings = {
            single_file_support = true,
          },
        },
      },
      setup = {},
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
      -- No need to set `hybridMode` to `true` as it's the default value
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
          'typescript',
          'javascript',
          'javascriptreact',
          'typescriptreact',
          'vue',
        },
      }
      -- No need to set `hybridMode` to `true` as it's the default value
      -- lspconfig.volar.setup {}

      lspconfig.volar.setup {}

      lspconfig.eslint.setup {
        on_attach = function(_, bufnr)
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
  },
}
