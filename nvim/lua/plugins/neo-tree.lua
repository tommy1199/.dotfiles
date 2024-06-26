return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  lazy = false,
  keys = {
    { "<leader>n", ":Neotree filesystem toggle left<CR>" }
  },
  opts = {
    filesystem = {
      hijack_netrw_behavior = 'open_current',
    }
  }
}
