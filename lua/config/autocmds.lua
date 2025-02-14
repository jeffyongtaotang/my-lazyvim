-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- tilt-ls required
vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = { "Tiltfile" },
  command = "setf tiltfile",
})

-- helm-ls required
vim.api.nvim_create_autocmd({ "BufRead" }, {
  pattern = { "*/templates/*.yaml", "*/templates/*.tpl" },
  command = "setf helm",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "json",
  callback = function(ev)
    vim.bo[ev.buf].formatexpr = ""
    vim.bo[ev.buf].formatprg = "jq"
  end,
})
