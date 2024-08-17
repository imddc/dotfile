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
        taplo = {
          keys = {
            {
              'K',
              function()
                if
                  vim.fn.expand '%:t' == 'Cargo.toml'
                  and require('crates').popup_available()
                then
                  require('crates').show_popup()
                else
                  vim.lsp.buf.hover()
                end
              end,
              desc = 'Show Crate Documentation',
            },
          },
        },
        gopls = {
          settings = {
            gopls = {
              gofumpt = true,
              codelenses = {
                gc_details = false,
                generate = true,
                regenerate_cgo = true,
                run_govulncheck = true,
                test = true,
                tidy = true,
                upgrade_dependency = true,
                vendor = true,
              },
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
              analyses = {
                fieldalignment = true,
                nilness = true,
                unusedparams = true,
                unusedwrite = true,
                useany = true,
              },
              usePlaceholders = true,
              completeUnimported = true,
              staticcheck = true,
              directoryFilters = {
                '-.git',
                '-.vscode',
                '-.idea',
                '-.vscode-test',
                '-node_modules',
              },
              semanticTokens = true,
            },
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

      -- volar + tsserver
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
          'typescript',
          'javascript',
          'javascriptreact',
          'typescriptreact',
          'vue',
        },
      }
      lspconfig.volar.setup {}

      -- eslint
      local customizations = {
        { rule = 'style/*', severity = 'off', fixable = true },
        { rule = 'format/*', severity = 'off', fixable = true },
        { rule = '*-indent', severity = 'off', fixable = true },
        { rule = '*-spacing', severity = 'off', fixable = true },
        { rule = '*-spaces', severity = 'off', fixable = true },
        { rule = '*-order', severity = 'off', fixable = true },
        { rule = '*-dangle', severity = 'off', fixable = true },
        { rule = '*-newline', severity = 'off', fixable = true },
        { rule = '*quotes', severity = 'off', fixable = true },
        { rule = '*semi', severity = 'off', fixable = true },
      }
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
          'javascript.jsx',
          'typescript',
          'typescriptreact',
          'typescript.tsx',
          'vue',
          'html',
          'markdown',
          'json',
          'jsonc',
          'yaml',
          'toml',
          'xml',
          'gql',
          'graphql',
          'astro',
          'svelte',
          'css',
          'less',
          'scss',
          'pcss',
          'postcss',
        },
        settings = {
          -- Silent the stylistic rules in you IDE, but still auto fix them
          rulesCustomizations = customizations,
        },
      }

      -- html
      lspconfig.html.setup { capabilities = capabilities, filetypes = { 'html' } }
      -- css
      lspconfig.cssls.setup {
        capabilities = capabilities,
        filetypes = {
          'css',
          'scss',
          'less',
          'sass',
          'vue',
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

      -- rust
      lspconfig.rust_analyzer.setup {
        capabilities = capabilities,
      }

      -- go
      lspconfig.gopls.setup {
        capabilities = capabilities,
      }

      -- go format
      lspconfig.gofumpt.setup {
        capabilities = capabilities,
      }

      -- markdown
      lspconfig.markdownlint.setup {
        capabilities = capabilities,
      }

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
