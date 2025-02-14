local Terminal = require("toggleterm.terminal").Terminal

function Lazygit_toggle()
  local lazygit = Terminal:new({
    cmd = "/opt/homebrew/Cellar/lazygit/0.40.2/bin/lazygit",

    dir = "git_dir",
    direction = "float",
    float_opts = {
      border = "single",
    },
    -- function to run on opening the terminal
    on_open = function(term)
      vim.cmd("startinsert!")
      vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", { noremap = true, silent = true })
    end,
    -- function to run on closing the terminal
    on_close = function()
      vim.cmd("startinsert!")
    end,
  })

  lazygit:toggle()
end

return {}
