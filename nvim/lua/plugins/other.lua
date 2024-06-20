return {
  'mg979/vim-visual-multi',
  'f-person/git-blame.nvim',
  -- 'github/copilot.vim',
  -- 'norcalli/nvim-colorizer.lua',

  -- mini indent
  -- { 'echasnovski/mini.nvim', version = '*' },
  {
    'echasnovski/mini.nvim',
    version = false,
    config = function()
      require('mini.indentscope').setup {}
    end,
  },

  -- auto close pairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {},
  },
}
