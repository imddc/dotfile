vim.g.mapleader = ' '
local keymap = vim.keymap

-- esc
keymap.set('i', 'jj', '<ESC>')
-- keymap.set('i', 'jk', '<ESC>')
-- keymap.set('i', 'kk', '<ESC>')

keymap.set('n', '<c-s-a>', 'ggVG')

keymap.set('n', 'x', '"_x')
keymap.set('n', 'dw', 'vb"_d')

keymap.set('n', 'H', '^')
keymap.set('n', 'L', '$')

-- space + s  => save
keymap.set('n', '<leader>s', '<cmd>w<cr>')

-- keymap.set('n', 'j', [[v:count?'j':'gj']], { noremap = true, expr = true })
-- keymap.set('n', 'k', [[v:count?'k':'gk']], { noremap = true, expr = true })

-- cancle highlights
keymap.set('n', '<leader>nh', ':nohl<CR>', { desc = 'Clear search highlights' })

-- bufferline
keymap.set('n', '<c-h>', ':BufferLineCyclePrev<cr>')
keymap.set('n', '<c-l>', ':BufferLineCycleNext<cr>')
-- keymap.set('n', '<c-s-h>', ':BufferLineMovePrev<cr>')
-- keymap.set('n', '<c-s-l>', ':BufferLineMoveNext<cr>')
keymap.set('n', "<leader>'", ':BufferLineCloseOthers<cr>')
keymap.set('n', '<leader>q', ':BufferLinePickClose<cr>')

-- indent
keymap.set('v', '<', '<gv')
keymap.set('v', '>', '>gv')

-- choose then  move under or above line
keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

--
keymap.set('n', '<leader>d', '<cmd>Telescope neovim-project discover<cr>')
keymap.set('n', '<leader>h', '<cmd>Telescope neovim-project history<cr>')

local builtin = require 'telescope.builtin'
keymap.set('n', '<leader>,', builtin.find_files, {})
keymap.set('n', '<leader>.', builtin.live_grep, {})

keymap.set('n', 'i', function()
  return string.match(vim.api.nvim_get_current_line(), '%g') == nil and 'cc'
    or 'i'
end, { expr = true, noremap = true })
