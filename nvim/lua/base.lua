local opt = vim.opt

vim.scriptencoding = 'utf-8'
opt.encoding = 'utf-8'
opt.fileencoding = 'utf-8'

opt.signcolumn = 'yes'
opt.number = true
opt.relativenumber = true

opt.scrolloff = 10
opt.sidescrolloff = 5

opt.hlsearch = true
opt.incsearch = true

opt.mouse:append 'a'
opt.clipboard:append 'unnamedplus'

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true

opt.ignorecase = true
opt.smartcase = true

opt.swapfile = false
opt.autoread = true
vim.bo.autoread = true

opt.cursorline = true
-- opt.termguicolors = true
opt.showmode = false

-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.opt.pumblend = 0
vim.opt.updatetime = 200

vim.g.rustaceanvim = {
  tools = {
    float_win_config = {
      border = 'rounded',
    },
  },
}
