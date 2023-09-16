-- use vim key binding in termination mode
vim.keymap.set("t", "<C-n>", "<C-\\><C-n>")

-- toggle file tree
vim.keymap.set("n", "<Space>e", "<cmd>NvimTreeToggle<CR>")

-- tab naviation
vim.keymap.set("n", "<C-s>", ":w<cr>")
vim.keymap.set("n", "<C-l>", "<Plug>(cokeline-focus-next)")
vim.keymap.set("n", "<C-h>", "<Plug>(cokeline-focus-prev)")
vim.keymap.set("n", "<C-c>", ":bdelete<cr>")

-- NOTE:remove the default lazygit binding
vim.keymap.del('n', '<leader>gg')
vim.keymap.del('n', '<leader>gG')

-- which-keys
require("which-key").register({
  ["<leader>P"] = {
    function()
      require("telescope").extensions.project.project({ display_type = "full" })
    end,
    "[p]ick a Prject",
  },
  ["<leader>cp"] = {
    "<cmd>lua require'cmd.preview_current_file'.run()<cr>", "file [p]review"
  },
  ["<leader>cs"] = {
    "<cmd>lua require'cmd.run_package_json_script'.select_and_run_script()<cr>", "Run Project Script"
  },
  ["<leader>r"] = {
    name = "Rest API Request",
    ["r"] = {
      "<Plug>RestNvim<cr>", "Run Request under the cursor"
    },
    ["p"] = {
      "<Plug>RestNvimPreview<cr>", "Preview cURL command"
    },
    ["R"] = {
      "<Plug>RestNvimLast<cr>", "Re-run last Request"
    }
  }
})
