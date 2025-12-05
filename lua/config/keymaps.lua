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
vim.keymap.del("n", "<leader>gg")
vim.keymap.del("n", "<leader>gG")
-- -- NOTE:remove the default lazy binding
vim.keymap.del("n", "<leader>l")

-- which-keys
require("which-key").add({
  { "<leader>gl", "<cmd>lua Lazygit_toggle()<CR>", desc = "Toggle Lazy Git", mode = "n" },
  {
    "<leader>P",
    function()
      require("telescope").extensions.project.project({ display_type = "full" })
    end,
    desc = "[p]ick a Prject",
  },
  { "<leader>cp", "<cmd>lua require'cmd.preview_current_file'.run()<cr>", desc = "file [p]review" },
  {
    "<leader>cs",
    "<cmd>lua require'cmd.run_package_json_script'.select_and_run_script()<cr>",
    desc = "Run Project Script",
  },
  -- @TODO:
  -- {
  --   "<leader>cr",
  --   name = "rust tools",
  --   r = {
  --     "<cmd>lua require'rust-tools.runnables'.runnables()<cr>",
  --     "runnables",
  --   },
  --   h = {
  --     "<cmd>lua require'rust-tools.hover_actions'.hover_actions()<cr>",
  --     "hover actions",
  --   },
  --   m = {
  --     "<cmd>lua require'rust-tools.expand_macro'.expand_macro()<cr>",
  --     "expand macro",
  --   },
  --   a = {
  --     "<cmd>lua require'rust-tools.code_action_group'.code_action_group()<cr>",
  --     "code action group",
  --   },
  --   g = {
  --     "<cmd>lua require'rust-tools.crate_graph'.view_crate_graph('png', 'crate_graph.png')<cr>",
  --     "crate graph",
  --   },
  -- },
  { "<leader>rr", "<cmd>Rest run<cr>", desc = "Open Rest Request UI" },
})
