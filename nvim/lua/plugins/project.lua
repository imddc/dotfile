return {
  'coffebar/neovim-project',
  event = 'VeryLazy',
  opts = {
    projects = { -- define project roots
      '~/workspace/*',
      '~/Desktop/item/front/*',
      '~/Desktop/item/forks/*',
      '~/Desktop/item/jz/*',
      '~/Desktop/item/node/*',
      '~/Desktop/item/rust/*',
      '~/Desktop/item/go/*',
      '~/Desktop/item/backend/*',
      '~/Desktop/item/electron/*',
      '~/Desktop/item/test-demo/*',
      '~/Desktop/item/monorepo/*',
      '~/Desktop/item/broswer-plugins/*',
    },
    -- _extmark_signs = false,
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'Shatur/neovim-session-manager' },
    -- { 'nvim-telescope/telescope.nvim', tag = '0.1.4' },
  },
  lazy = false,
  priority = 100,
}
