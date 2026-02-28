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

-- OAS
local function looks_like_openapi(bufnr)
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 80, false)
  for _, line in ipairs(lines) do
    if line:match("^%s*openapi:%s*") or line:match("^%s*swagger:%s*") then
      return true
    end
  end
  return false
end

vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = {
    "openapi*.yaml",
    "openapi*.yml",
    "*openapi*.yaml",
    "*openapi*.yml",
    "swagger*.yaml",
    "swagger*.yml",
    "openapi*.json",
    "*openapi*.json",
    "swagger*.json",
  },
  callback = function(args)
    local lspconfig = require("lspconfig")
    -- optional: only attach if it contains top-level openapi:/swagger:
    -- comment out if you want filename-only matching
    if not looks_like_openapi(args.buf) then
      print("Current file not looking like supported OAS")
      return
    end

    print("matched OAS file")

    -- avoid duplicate clients
    for _, c in ipairs(vim.lsp.get_clients({ bufnr = args.buf })) do
      if c.name == "openapi_ls" then
        return
      end
    end

    -- attach using lspconfig-managed lifecycle (stable)
    lspconfig.openapi_ls.manager.try_add(args.buf)
  end,
})
