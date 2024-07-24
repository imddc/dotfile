if vim.g.neovide then
  vim.o.guifont = 'JetbrainsMono Nerd Font:h20:i'
  -- vim.o.guifont = 'FiraCode Nerd Font Mono:h20:i'
  -- vim.o.guifont = 'Maple Mono:h20'
  -- vim.o.guifont = 'CaskaydiaCove Nerd Font Mono:h22:i'
  -- line height
  vim.opt.linespace = 2
  -- vim.g.neovide_scale_factor = 1.6
  vim.g.neovide_window_bluerred = true

  -- 启用 Neovide 光标动效，选择 wireframe 模式
  vim.g.neovide_cursor_vfx_mode = 'torpedo'
  -- vim.g.neovide_cursor_vfx_mode = 'railgun'
  -- vim.g.neovide_cursor_vfx_mode = 'wireframe'

  -- 其他可选配置，可以根据需要调整
  vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
  vim.g.neovide_cursor_vfx_particle_density = 12.0
  vim.g.neovide_cursor_vfx_particle_speed = 10.0
  vim.g.neovide_cursor_vfx_particle_phase = 1.5
  vim.g.neovide_cursor_vfx_particle_curl = 1.0

  vim.g.neovide_transparency = 0.9

  -- padding
  vim.g.neovide_padding_top = 0
  vim.g.neovide_padding_bottom = 0
  vim.g.neovide_padding_right = 0
  vim.g.neovide_padding_left = 0

  -- window
  vim.g.neovide_window_blurred = true
  vim.g.neovide_floating_blur_amount_x = 0.5
  vim.g.neovide_floating_blur_amount_y = 0.5

  -- dynamic scale
  local change_scale_factor = function(delta)
    vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
  end
  vim.keymap.set('n', '<D-=>', function()
    change_scale_factor(1.25)
  end)
  vim.keymap.set('n', '<D-->', function()
    change_scale_factor(1 / 1.25)
  end)

  vim.keymap.set('n', '<D-s>', ':w<CR>') -- Save
  vim.keymap.set('v', '<D-c>', '"+y') -- Copy
  vim.keymap.set('n', '<D-v>', '"+P') -- Paste normal mode
  vim.keymap.set('v', '<D-v>', '"+P') -- Paste visual mode
  vim.keymap.set('c', '<D-v>', '<C-R>+') -- Paste command mode
  vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode

  -- Allow clipboard copy paste in neovim
  vim.api.nvim_set_keymap(
    '',
    '<D-v>',
    '+p<CR>',
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    '!',
    '<D-v>',
    '<C-R>+',
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    't',
    '<D-v>',
    '<C-R>+',
    { noremap = true, silent = true }
  )
  vim.api.nvim_set_keymap(
    'v',
    '<D-v>',
    '<C-R>+',
    { noremap = true, silent = true }
  )
end
