return {
  'nvim-lualine/lualine.nvim',
  opts = {
    options = {
      icons_enabled = true,
      component_separators = '|',
      section_separators = '',
    },
  },
  config = function(_, opts)
    local catppuccin = require 'lualine.themes.catppuccin-macchiato'
    catppuccin.normal.c.bg = '#303030'
    opts.options.theme = catppuccin
    require('lualine').setup(opts)
  end,
}
