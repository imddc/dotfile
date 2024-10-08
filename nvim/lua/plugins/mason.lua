return {
  {
    'williamboman/mason.nvim',
    optional = true,
    opts = {
      ensure_installed = {
        'stylua',
        'selene',

        'shellcheck',
        'shfmt',
        -- frontend
        'html-lsp',
        'css-lsp',
        'eslint-lsp',
        'biome',
        'prettier',
        -- markdown
        'markdownlint',
        'marksman',
        -- docker
        'hadolint',

        -- rust
        'codelldb',

        -- go
        'gopls',
        'gofumpt',

        -- java
        'jdtls',
        'google-java-format',
      },
    },
  },
}
