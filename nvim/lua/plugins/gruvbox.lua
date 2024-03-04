return {
  -- Theme inspired by Atom
  'morhetz/gruvbox',
  priority = 1000,
  config = function()
    vim.cmd.colorscheme 'gruvbox'
  end,
}
