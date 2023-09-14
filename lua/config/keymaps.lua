-- use vim key binding in termination mode
vim.keymap.set("t", "<C-n>", "<C-\\><C-n>")

-- toggle file tree
vim.keymap.set("n", "<Space>e", "<cmd>NvimTreeToggle<CR>")

-- tab naviation
vim.keymap.set("n", "<C-s>", ":w<cr>")
vim.keymap.set("n", "<C-l>", "<Plug>(cokeline-focus-next)")
vim.keymap.set("n", "<C-h>", "<Plug>(cokeline-focus-prev)")
vim.keymap.set("n", "<C-c>", ":bdelete<cr>")

local wk = require("which-key")

wk.register({
  ["P"] = {
    function()
      require("telescope").extensions.project.project({ display_type = "full" })
    end,
    "[p]ick a Prject",
  },
})
