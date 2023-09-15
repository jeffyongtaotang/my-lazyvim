-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- tilt-ls required
vim.api.nvim_create_autocmd({ 'BufRead' }, {
  pattern = { 'Tiltfile' },
  command = 'setf tiltfile'
})
