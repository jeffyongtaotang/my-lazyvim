return {
  -- disable built-in plugin
  { "bufferline.nvim", enabled = false },
  { "nvim-neo-tree/neo-tree.nvim", enabled = false },
  -- built-in plugins
  {
    "hrsh7th/nvim-cmp",
    opts = function(_, opts)
      local cmp = require("cmp")

      opts.mapping["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert })
      opts.mapping["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert })
    end,
  },
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
          vim.keymap.set("n", "v", api.node.open.vertical, opts("Open: Vertical Split"))
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
          float = {
            enable = true,
            open_win_config = {
              width = 100,
              height = 100,
            },
          },
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          git_ignored = false,
        },
      })
    end,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    event = "User DirOpened",
  },
  {
    "lewpoly/sherbet.nvim",
  },
  { "bluz71/vim-nightfly-colors", name = "nightfly", lazy = false, priority = 1000 },
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
  {
    "rcarriga/nvim-dap-ui",
    keys = function()
      return {
        {
          "<leader>du",
          function()
            local dap_ui = require("dapui")
            dap_ui.toggle({ layout = 1, reset = true })
          end,
          desc = "Dap Console",
        },
        {
          "<leader>dr",
          function()
            local dap_ui = require("dapui")
            dap_ui.float_element("repl", {
              title = "Repl",
              position = "center",
              width = 40,
              height = 20,
              enter = true,
            })
          end,
          desc = "Dap Repl",
        },
        {
          "<leader>ds",
          function()
            local dap_ui = require("dapui")
            dap_ui.float_element("scopes", {
              title = "Scopes",
              position = "center",
              width = 80,
              height = 100,
              enter = true,
            })
          end,
          desc = "Dap Scope",
        },
        {
          "<leader>dS",
          function()
            local dap_ui = require("dapui")
            dap_ui.float_element("stacks", {
              title = "Stacks",
              position = "center",
              width = 80,
              height = 100,
              enter = true,
            })
          end,
          desc = "Dap Scope",
        },
        {
          "<leader>dB",
          function()
            local dap_ui = require("dapui")
            dap_ui.float_element("breakpoints", {
              title = "Breakpoints",
              position = "center",
              width = 80,
              height = 100,
              enter = true,
            })
          end,
          desc = "Dap Scope",
        },
      }
    end,
    opts = {
      layouts = {
        -- NOTE: Single console column on the right
        {
          elements = {
            {
              id = "console",
              size = 0.65,
            },
            {
              id = "repl",
              size = 0.35,
            },
          },
          position = "right",
          size = 80,
        },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      local open_console = function()
        dapui.close({ layout = 1 })
        dapui.toggle({ layout = 1, reset = true })
      end

      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = open_console
      dap.listeners.after.event_exited["finish"] = open_console
    end,
  },
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "williamboman/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}

          table.insert(opts.ensure_installed, "js-debug-adapter")
          table.insert(opts.ensure_installed, "codelldb")
        end,
      },
    },
    opts = function()
      require("dap").adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            require("mason-registry").get_package("js-debug-adapter"):get_install_path()
              .. "/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      local mason_registry = require("mason-registry")
      local codelldb_root = mason_registry.get_package("codelldb"):get_install_path() .. "/extension/"
      local codelldb_path = codelldb_root .. "adapter/codelldb"
      local liblldb_path = codelldb_root .. "lldb/lib/liblldb.so"

      require("dap").adapters["rust"] = {
        type = "server",
        host = "127.0.0.1",
        port = "${port}",
        executable = {
          command = codelldb_path,
          args = { "--liblldb", liblldb_path, "--port", "${port}" },
        },
      }
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvimtools/none-ls-extras.nvim",
    },
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {

          require("none-ls.formatting.eslint_d").with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
          }),
          require("none-ls.diagnostics.eslint_d").with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
          }),
          require("none-ls.code_actions.eslint").with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
          }),
        },
      })
    end,
  },
  {
    "rest-nvim/rest.nvim",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      opts = function(_, opts)
        opts.ensure_installed = opts.ensure_installed or {}
        table.insert(opts.ensure_installed, "http")
      end,
    },
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPrevkew", "MarkdownPreviewStop" },
    build = "cd app && yarn install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    "simrat39/rust-tools.nvim",
    opts = {
      tools = {
        hover_actions = {
          auto_focus = true,
        },
      },
    },
  },
}
