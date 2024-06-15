return {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.4',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local builtin = require 'telescope.builtin'
    local keymap = vim.keymap
    keymap.set('n', '<leader>,', builtin.find_files, {})
    keymap.set('n', '<leader>.', builtin.live_grep, {})

    local actions = require 'telescope.actions'
    require('telescope').setup {
      defaults = {
        mappings = {
          i = {
            ['esc'] = actions.close,
          },
        },
        file_ignore_patterns = {
          'codegen.ts',
          '.git',
          'lazy-lock.json',
          '*-lock.yaml',
          'node_modules',
          '%.lock',
        },
        dynamic_preview_title = true,
        path_display = { 'smart' },
      },
      pickers = {
        find_files = {
          hidden = true,
        },
      },
      layout_config = {
        horizontal = {
          preview_cutoff = 100,
          preview_width = 0.5,
        },
      },
      extensions = {
        package_info = {
          -- Optional theme (the extension doesn't set a default theme)
          theme = 'ivy',
        },
      },
    }

    require('telescope').load_extension 'package_info'
  end,
}
