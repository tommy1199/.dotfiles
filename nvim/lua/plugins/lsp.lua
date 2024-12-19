return {
  {
    'williamboman/mason.nvim',
    opts = {},
  },
  {
    'williamboman/mason-lspconfig',
    opts = {
      ensure_installed = {
        'lua_ls',
        'ts_ls',
        'rust_analyzer',
      },
    },
  },
  {
    'neovim/nvim-lspconfig',
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local lspconfig = require 'lspconfig'
      lspconfig.lua_ls.setup {
        capabilities = capabilities,
      }
      lspconfig.ts_ls.setup {
        capabilities = capabilities,
      }
      lspconfig.rust_analyzer.setup {
        capabilities = capabilities,
      }
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
      vim.keymap.set('n', '<leader>cgd', vim.lsp.buf.definition, { desc = '[g]oto [d]efinition' })
      vim.keymap.set('n', '<leader>cgi', vim.lsp.buf.implementation, { desc = '[g]oto [i]mplementation' })
      vim.keymap.set('n', '<leader>cgr', vim.lsp.buf.references, { desc = '[g]oto [i]mplementation' })
      vim.keymap.set({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, { desc = 'code [a]ction' })
      vim.keymap.set({ 'n', 'v' }, '<leader>cr', vim.lsp.buf.rename, { desc = '[r]ename' })
      vim.keymap.set({'n', 'v'}, '<leader>cs', vim.lsp.buf.document_symbol, {desc = '[s]ymbols'})
    end,
    dependencies = {
      { 'folke/neodev.nvim', opts = {} },
      { 'j-hui/fidget.nvim', opts = {} },
    },
  },
}
