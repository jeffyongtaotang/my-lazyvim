require("lspconfig")["yamlls"].setup({
  on_attach = function(_, bufnr)
    local current_buf_path = vim.api.nvim_buf_get_name(0)

    -- In case to let "helm_ls" works correctly, disable diagnostic for helm file yaml
    if string.match(current_buf_path, ".*/templates/.*.yaml") ~= nil or string.match(current_buf_path, ".*/templates/.*.tpl") ~= nil then
      vim.diagnostic.disable()
    end
  end,
  settings = {
    yaml = {
      schemas = {
        -- kol configuration schema
        ["/Users/jeff.tong@konghq.com/Coding/konnect-on-call-tool-kit/cmd/local-dev/schemas/configuration.schema.yaml"] = "*.kol.config.yaml",
        ["http://json-schema.org/draft-07/schema"] = "/cmd/local-dev/**/*.schema.yaml",
      }
    }
  }
})
