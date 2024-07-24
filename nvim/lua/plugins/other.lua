return {
  'mg979/vim-visual-multi',
  'f-person/git-blame.nvim',

  -- 添加 emoji
  {
    'hrsh7th/nvim-cmp',
    dependencies = { 'hrsh7th/cmp-emoji' },
    opts = function(_, opts)
      table.insert(opts.sources, { name = 'emoji' })
    end,
  },
}
