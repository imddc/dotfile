return {
  {
    'stevearc/conform.nvim',
    opts = function()
      require('conform').setup {
        formatters_by_ft = {
          go = { 'goimports', 'gofumpt' },
          lua = { 'stylua' },
          rust = { 'rustfmt' },
          javascript = { 'biome-check', 'prettier' },
          typescript = { 'biome-check', 'prettier' },
          javascriptreact = { 'biome-check', 'prettier' },
          typescriptreact = { 'biome-check', 'prettier' },
          tsx = { 'biome-check', 'prettier' },
          css = { 'biome-check', 'prettier' },
          json = { 'biome-check', 'prettier' },
          toml = { 'taplo' },
        },
        format_on_save = {
          timeout_ms = 500,
          lsp_format = 'fallback',
        },
        notify_no_formatters = true,
        notify_on_error = true,
      }

      vim.api.nvim_create_autocmd('BufWritePre', {
        group = vim.api.nvim_create_augroup('EslintFixAll', { clear = true }),
        pattern = { '*.tsx', '*.ts', '*.jsx', '*.js' },
        command = 'silent! EslintFixAll',
      })
    end,
  },
}
