return {
  'stevearc/conform.nvim',
  lazy = true,
  event = { 'BufReadPre', 'BufNewFile' }, -- to disable, comment this out
  config = function()
    require('conform').setup {

      formatters_by_ft = {
        lua = { 'stylua' },
        -- vue = { 'prettier' },
        -- javascript = { 'prettier' },
        -- typescript = { 'prettier' },
        -- javascriptreact = { 'prettier' },
        -- typescriptreact = { 'prettier' },
        css = { 'prettier' },
        html = { 'prettier' },
        json = { 'prettier' },
        yaml = { 'prettier' },
        markdown = { 'prettier' },
        graphql = { 'prettier' },
      },
      format_on_save = {
        pattern = '.lua,*.graphql,*.css,*.html,*.json,*.yaml,*.md,*.gql,*.rs',
        timeout_ms = 500,
        async = false,
        lsp_fallback = true,
      },
    }
  end,
}
