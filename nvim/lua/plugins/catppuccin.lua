return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin-macchiato'
  end,
  opts = {
    background = {
      light = 'macchiato',
      dark = 'macchiato',
    },
    transparent_background = true,
    term_colors = true,
    integrations = {
      neotree = true,
    },
    color_overrides = {
      all = {
        mantle = '#303030',
      },
    },
  },
}
