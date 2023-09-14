return {
  -- disable built-in plugin
  { "bufferline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  {
    "nvim-telescope/telescope.nvim",
    opts = function(_, opts)
      local actions = require("telescope.actions")

      opts.defaults = {
        -- Default configuration for telescope goes here:
        -- config_key = value,
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
          -- for normal mode
          n = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
          },
        },
      }
    end,
  },
  -- custom plugins
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      require("nvim-tree").setup({
        on_attach = function(bufnr)
          local api = require("nvim-tree.api")

          local function opts(desc)
            return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
          end

          api.config.mappings.default_on_attach(bufnr)

          vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
          vim.keymap.set("n", "o", api.node.open.edit, opts("Open"))
          vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
          vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Verical Split"))
          vim.keymap.set("n", "h", api.node.navigate.parent_close, opts("Close Directory"))
          vim.keymap.set("n", "C", api.tree.change_root_to_node, opts("CD"))
        end,
        respect_buf_cwd = true,
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        sort_by = "case_sensitive",
        view = {
          width = 30,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
        },
      })
    end,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    event = "User DirOpened",
  },
  {
    "lewpoly/sherbet.nvim",
  },
  {
    "nvim-telescope/telescope-project.nvim",
    event = "BufWinEnter",
    setup = function()
      vim.cmd([[packadd telescope.nvim]])
    end,
  },
  {
    "startup-nvim/startup.nvim",
    requires = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    config = function()
      require("startup").setup({})
    end,
  },
  {
    -- Bufferline not working correctly with Telescope-project, use "Cokeline" instead.
    "willothy/nvim-cokeline",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for v0.4.0+
    },
    config = true,
  },
  { "towolf/vim-helm" },
  {
    -- Might require some manual step, if ":MarkdownPreview" not working.
    -- ref: https://github.com/iamcco/markdown-preview.nvim/issues/424
    "iamcco/markdown-preview.nvim",
    run = "cd app && npm install",
    ft = "markdown",
    config = function()
      vim.g.mkdp_auto_start = 1
    end,
  },
  {
    "vinnymeller/swagger-preview.nvim",
    run = "npm install -g swagger-ui-watcher",
  },
  {
    "cuducos/yaml.nvim",
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-telescope/telescope.nvim", -- optional
    },
  },
  {
    {
      "akinsho/toggleterm.nvim",
      version = "*",
      opts = {
        active = true,
        on_config_done = nil,
        size = 20,
        open_mapping = [[<c-\>]],
        hide_numbers = true, -- hide the number column in toggleterm buffers
        shade_filetypes = {},
        shade_terminals = true,
        shading_factor = 2, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
        start_in_insert = true,
        insert_mappings = true, -- whether or not the open mapping applies in insert mode
        persist_size = false,
        -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
        direction = "float",
        close_on_exit = true, -- close the terminal window when the process exits
        shell = nil, -- change the default shell
        float_opts = {
          border = "curved",
          winblend = 0,
          highlights = {
            border = "Normal",
            background = "Normal",
          },
        },
        execs = {
          { nil, "<M-1>", "Horizontal Terminal", "horizontal", 0.3 },
          { nil, "<M-2>", "Vertical Terminal", "vertical", 0.4 },
          { nil, "<M-3>", "Float Terminal", "float", nil },
        },
      },
    },
  },
}
