return {
  "MaximilianLloyd/ascii.nvim",
  {
    'goolord/alpha-nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons', "MaximilianLloyd/ascii.nvim" },
    config = function()
      local alpha = require 'alpha'
      local dashboard = require 'alpha.themes.startify'
      local ascii = require 'ascii'
      dashboard.section.header.val = ascii.art.text.neovim.sharp
      dashboard.section.header.opts = {
        position = "center",
        hl = "AlphaHeader"
      }
      alpha.setup(dashboard.config)
    end
  }
}
