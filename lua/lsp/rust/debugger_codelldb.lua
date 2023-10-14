local dap = require('dap')

dap.configurations.rust = {
  {
    name = "Run file",
    type = "codelldb",
    request = "launch",
    cargo = {
      args = {
        "build",
      }
    },
    program = function()
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    showDisassembly = "never",
    terminal = 'integrated',
    sourceLanguages = { 'rust' }
  },
}
