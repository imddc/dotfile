-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
--
vim.g.mapleader = " "

local set = vim.keymap.set

-- set({ "n", "t" }, "<C-h>", "<CMD>NavigatorLeft<CR>", { desc = "Navigate Left", silent = true })
-- set({ "n", "t" }, "<C-l>", "<CMD>NavigatorRight<CR>", { desc = "Navigate Right", silent = true })
-- set({ "n", "t" }, "<C-k>", "<CMD>NavigatorUp<CR>", { desc = "Navigate Up", silent = true })
-- set({ "n", "t" }, "<C-j>", "<CMD>NavigatorDown<CR>", { desc = "Navigate Down", silent = true })

-- set("n", "<leader>kk", "<CMD>w<CR><ESC>", { desc = "Save File", noremap = true, silent = true, nowait = true })
-- set("n", "<leader>wq", "<CMD>wq<CR>", { desc = "Save File And Quit", silent = true, noremap = true, nowait = true })
-- set("n", "<leader>dd", LazyVim.ui.bufremove, { desc = "Delete Buffer", silent = true, noremap = true, nowait = true })

-- set("n", "i", function()
--   return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
-- end, { expr = true, noremap = true })

-- esc
set("i", "jj", "<ESC>")
-- keymap.set('i', 'jk', '<ESC>')
-- keymap.set('i', 'kk', '<ESC>')

set("n", "<c-s-a>", "ggVG")

set("n", "x", '"_x')
set("n", "dw", 'vb"_d')

set("n", "H", "^")
set("n", "L", "$")

-- space + s  => save
set("n", "<leader>s", "<cmd>w<cr>")

-- set('n', 'j', [[v:count?'j':'gj']], { noremap = true, expr = true })
-- set('n', 'k', [[v:count?'k':'gk']], { noremap = true, expr = true })

-- cancle highlights
set("n", "<leader>nh", ":nohl<CR>", { desc = "Clear search highlights" })

-- bufferline
set("n", "<c-h>", ":BufferLineCyclePrev<cr>")
set("n", "<c-l>", ":BufferLineCycleNext<cr>")
-- set('n', '<c-s-h>', ':BufferLineMovePrev<cr>')
-- keymap.set('n', '<c-s-l>', ':BufferLineMoveNext<cr>')
set("n", "<leader>'", ":BufferLineCloseOthers<cr>")
set("n", "<leader>q", ":BufferLinePickClose<cr>")

-- indent
set("v", "<", "<gv")
set("v", ">", ">gv")

-- choose then  move under or above line
set("v", "J", ":m '>+1<CR>gv=gv")
set("v", "K", ":m '<-2<CR>gv=gv")

--
set("n", "<leader>d", "<cmd>Telescope neovim-project discover<cr>")
set("n", "<leader>h", "<cmd>Telescope neovim-project history<cr>")

-- local builtin = require 'telescope.builtin'
-- set('n', '<leader>,', builtin.find_files, {})
-- set('n', '<leader>.', builtin.live_grep, {})

set("n", "i", function()
  return string.match(vim.api.nvim_get_current_line(), "%g") == nil and "cc" or "i"
end, { expr = true, noremap = true })
