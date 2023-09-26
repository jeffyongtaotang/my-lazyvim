local get_hex = require('cokeline.hlgroups').get_hl_attr
local yellow = vim.g.terminal_color_3

require("cokeline").setup({
  sidebar = {
    filetype = "NvimTree",
    components = {
      {
        text = "  Explorer",
        fg = yellow,
        bg = get_hex("NvimTreeNormal", "bg"),
        style = "bold",
      },
    },
  },
})

return {}
