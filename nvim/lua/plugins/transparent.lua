return {
  'xiyaowong/transparent.nvim',
  opts = {
    extra_groups = {
      'NeoTreeNormal',
      'NeoTreeNormalNC',
    },
    exclude_groups = {
      'NotifyBackground',
    },
  },
  lazy = false,
  config = function()
    require('transparent').clear_prefix 'NeoTree'
  end,
}
