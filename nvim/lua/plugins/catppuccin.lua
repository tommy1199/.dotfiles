return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'catppuccin-macchiato'
  end,
  opts = {
    flavour = 'macchiato',
    background = {
      light = 'macchiato',
      dark = 'macchiato',
    },
    term_colors = true,
    integrations = {
      neotree = true,
    },
    color_overrides = {
      all = {
        base = '#303030',
        mantle = '#303030',
      },
    },
  },
}
