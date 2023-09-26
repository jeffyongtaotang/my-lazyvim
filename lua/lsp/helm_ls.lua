local util = require('lspconfig.util')

require("lspconfig").tilt_ls.setup({
  cmd = { "helm_ls", "serve" },
  filetypes = { "helm" },
  root_dir = function(fname)
    return util.root_pattern('Chart.yaml')(fname)
  end,
})

return {}
