return {
  'mfussenegger/nvim-lint',
  envent = {
    'BufReadPre',
    'BufNewFile',
  },
  config = function()
    local lint = require 'lint'

    lint.linters_by_ft = {
      javascript = { 'eslint' },
      typescript = { 'eslint' },
      javascriptreact = { 'eslint' },
      typescriptreact = { 'eslint' },
      vue = { 'eslint' },
    }

    local eslint_d = require 'lint.linters.eslint_d'
    eslint_d.args = vim.tbl_extend('force', {
      '--config',
      function()
        return vim.fn.getcwd() .. '/eslint.config.js'
      end,
    }, eslint_d.args)

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- lint.try_lint()
      end,
    })
  end,
}
