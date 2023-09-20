return {
  -- disable built-in plugin
  { "bufferline.nvim",             enabled = false },
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
    "jose-elias-alvarez/null-ls.nvim",
    opts = function()
      local null_ls = require("null-ls")

      return {
        sources = {
          null_ls.builtins.formatting.eslint_d.with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
          }),
          null_ls.builtins.diagnostics.eslint_d.with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
          }),
          null_ls.builtins.code_actions.eslint_d.with({
            filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "vue" },
          }),
          null_ls.builtins.diagnostics.cspell.with({
            filetypes = { "markdown", "txt" },
            -- Force the severity to be HINT
            diagnostics_postprocess = function(diagnostic)
              diagnostic.severity = vim.diagnostic.severity.HINT
            end,
          }),
          null_ls.builtins.code_actions.cspell.with({
            filetypes = { "markdown", "txt" },
          }),
        },
      }
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
    -- NOTE:
    -- from: https://github.com/iamcco/markdown-preview.nvim/issues/595#issuecomment-1630961979
    "iamcco/markdown-preview.nvim",
    build = "cd app && npm install",
    ft = "markdown",
    lazy = true,
    keys = { { "gm", "<cmd>MarkdownPreviewToggle<cr>", desc = "Markdown Preview" } },
    config = function()
      vim.g.mkdp_auto_close = true
      vim.g.mkdp_open_to_the_world = false
      vim.g.mkdp_open_ip = "127.0.0.1"
      vim.g.mkdp_port = "8765"
      vim.g.mkdp_browser = ""
      vim.g.mkdp_echo_preview_url = true
      vim.g.mkdp_page_title = "${name}"
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
      shading_factor = 2,     -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
      start_in_insert = true,
      insert_mappings = true, -- whether or not the open mapping applies in insert mode
      persist_size = false,
      -- direction = 'vertical' | 'horizontal' | 'window' | 'float',
      direction = "float",
      close_on_exit = true, -- close the terminal window when the process exits
      shell = nil,          -- change the default shell
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
        { nil, "<M-2>", "Vertical Terminal",   "vertical",   0.4 },
        { nil, "<M-3>", "Float Terminal",      "float",      nil },
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    keys = function()
      return {
        { "<leader>du", function() require("dapui").toggle({ reset = true, layout = 1 }) end, desc = "Dap Console" },
        {
          "<leader>dr",
          function() require("dapui").toggle({ reset = true, layout = 2 }) end,
          desc = "Dap Repl and Breakpoints"
        },
        {
          "<leader>dS",
          function() require("dapui").toggle({ reset = true, layout = 3 }) end,
          desc =
          "Dap Scope and Others"
        },
      }
    end,
    opts = {
      layouts = {
        -- NOTE: Single console column on the right
        {
          elements = {
            {
              id = 'console',
              size = 1
            }
          },
          position = 'right',
          size = 50
        },
        -- NOTE: Bottom control area
        {
          elements = {
            {
              id = 'breakpoints',
              size = 0.2
            },
            {
              id = 'repl',
              size = 0.8
            }
          },
          position = 'bottom',
          size = 20
        },
        -- NOTE: Other pane on the left
        {
          elements = {
            {
              id = 'scopes',
              size = 0.4
            },
            {
              id = 'stacks',
              size = 0.4
            },
            {
              id = 'watchers',
              size = 0.2
            },
          },
          position = 'left',
          size = 40
        },
      },
    },
    config = function(_, opts)
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup(opts)
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open({ reset = true, layout = 1 })
      end
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
    end
  },
  {
    "rest-nvim/rest.nvim",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("rest-nvim").setup({
        result_split_horizontal = false,
        result_split_in_place = false,
        skip_ssl_verification = true,
        encode_url = true,
        highlight = {
          enabled = true,
          timeout = 150,
        },
        result = {
          show_url = true,
          show_curl_command = false,
          show_http_info = true,
          show_headers = true,
          formatters = {
            json = "jq",
            html = function(body)
              return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
            end
          },
        },
        jump_to_request = false,
        env_file = '.env',
        custom_dynamic_variables = {},
        yank_dry_run = true,
      })
    end
  },
  {
    'simrat39/rust-tools.nvim',
    opts = {
      tools = {
        hover_actions = {
          auto_focus = true,
        }
      },
    }
  },
}
