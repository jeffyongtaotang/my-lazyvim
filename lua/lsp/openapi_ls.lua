local lspconfig = require("lspconfig")
local configs = require("lspconfig.configs")

if not configs.openapi_ls then
  print("Setting up openapi_ls LSP server")
  configs["openapi_ls"] = {
    default_config = {
      cmd = { vim.fn.exepath("openapi-language-server") },
      filetypes = { "yaml", "json" },
      root_dir = function(fname)
        local util = require("lspconfig").util
        return util.root_pattern(".git", "openapi.yaml", "openapi.yml", "swagger.yaml", "swagger.yml")(fname)
          or vim.fs.dirname(fname)
      end,
      single_file_support = true,
    },
  }
end

lspconfig.openapi_ls.setup({})
