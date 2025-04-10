return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    lazygit = {},
    notifier = {}


  },
  keys = {
    { "<leader>gf", function() Snacks.lazygit.log_file() end, desc = "Lazygit current file history" },
    { "<leader>gg", function() Snacks.lazygit() end,          desc = "Lazygit" },
    { "<leader>ö",  function() Snacks.terminal() end,         desc = "Toggle Terminal" },
  },
}
