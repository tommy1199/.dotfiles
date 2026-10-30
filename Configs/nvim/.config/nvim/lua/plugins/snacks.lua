return {
  {
    "folke/snacks.nvim",
    opts = {
      picker = {
        sources = {
          files = {
            hidden = true,
          },
          -- <leader>/ (live grep): include hidden files by default
          grep = {
            hidden = true,
          },
        },
      },
    },
  },
}
