vim.treesitter.language.register('python', 'tiltfile')

require("lspconfig").tilt_ls.setup({
  cmd = { "tilt", "lsp", "start" },
  filetypes = { "tiltfile" }
})

return {}
