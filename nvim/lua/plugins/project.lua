return {
  'coffebar/neovim-project',
  opts = {
    projects = { -- define project roots
      '~/workspace/*',
      '~/.config/*',
      '~/Desktop/item/front/*',
      '~/Desktop/item/forks/*',
      '~/Desktop/item/jz/*',
      '~/Desktop/item/node/*',
      '~/Desktop/item/rust/*',
      '~/Desktop/item/backend/*',
      '~/Desktop/item/electron/*',
      '~/Desktop/item/test-demo/*',
      '~/Desktop/item/mobile/*',
      '~/Desktop/item/monorepo/*',
    },
  },
  init = function()
    -- enable saving the state of plugins in the session
    vim.opt.sessionoptions:append 'globals' -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
  end,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'Shatur/neovim-session-manager' },
  },
  lazy = false,
  priority = 100,
}
