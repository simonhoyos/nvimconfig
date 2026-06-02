return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
      picker = {
        enabled = true,
        actions = {
          grep_add_glob = function(picker)
            local search = picker:filter().search or ""
            vim.ui.input({ prompt = "Glob filter: ", }, function(glob)
              if glob and glob ~= "" then
                picker:close()
                Snacks.picker.grep({ search = search, glob = glob, })
              end
            end)
          end,
        },
        layout = {
          preset = "default",
          layout = {
            box = "horizontal",
            width = 0.99,
            height = 0.99,
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              { win = "input", height = 1,     border = "bottom", },
              { win = "list",  border = "none", },
            },
            {
              win = "preview",
              title = "{preview}",
              border = "rounded",
              width = 0.5,
            },
          },
        },
        win = {
          input = {
            keys = {
              -- navigation in insert mode
              ["<C-j>"] = { "list_down", mode = { "i", "n", }, },
              ["<C-k>"] = { "list_up", mode = { "i", "n", }, },
              -- delete buffer from buffer picker
              ["<leader>d"] = { "bufdelete", mode = { "n", }, },
              -- which_key helper
              ["<C-h>"] = { "toggle_help", mode = { "i", "n", }, },
              -- add glob filter (mirrors telescope live-grep-args <C-i>)
              ["<M-i>"] = { "grep_add_glob", mode = { "i", "n", }, },
              -- send selected items to quickfix list
              ["<M-q>"] = { "qflist", mode = { "i", "n", }, },
            },
          },
          list = {
            keys = {
              ["<M-i>"] = { "grep_add_glob", mode = { "n", }, },
              ["<M-q>"] = { "qflist", mode = { "n", }, },
            },
          },
        },
        -- start in normal mode (mirrors telescope initial_mode = "normal")
        prompt = "",
        formatters = {
          file = {
            filename_first = false,
          },
        },
        sources = {
          files = {
            cmd = "rg",
            args = { "--hidden", "--unrestricted", "--files", "--sort", "path", },
            exclude = {
              "node_modules",
              "target",
              "dist",
              ".git",
              ".next",
              ".data",
              ".data-crdb",
              ".vercel",
              ".venv",
              "coverage",
              "conductor",
            },
          },
        },
      },
    },
    keys = {
      -- files
      {
        "<C-p>",
        function()
          Snacks.picker.files({
            cmd = "rg",
            args = { "--hidden", "--unrestricted", "--files", "--sort", "path", },
            exclude = {
              "node_modules", "target", "dist", ".git", ".next",
              ".data", ".data-crdb", ".vercel", ".venv", "coverage", "conductor",
            },
          })
        end,
        desc = "[NAV] Find files",
      },
      -- live grep (normal mode)
      {
        "<C-f>",
        function() Snacks.picker.grep() end,
        mode = "n",
        desc = "[NAV] Live grep",
      },
      -- grep selected word/visual selection
      {
        "<C-f>",
        function() Snacks.picker.grep_word({ focus = "list", }) end,
        mode = "v",
        desc = "[NAV] Grep selected string",
      },
      -- buffers
      {
        "<C-b>",
        function() Snacks.picker.buffers() end,
        desc = "[NAV] List buffers",
      },
      -- current buffer fuzzy find
      {
        "/",
        function() Snacks.picker.lines() end,
        desc = "[NAV] Fuzzy find in buffer",
      },
      -- git
      {
        "<leader>fgb",
        function() Snacks.picker.git_branches() end,
        desc = "[NAV] Git branches",
      },
      {
        "<leader>fgc",
        function() Snacks.picker.git_log() end,
        desc = "[NAV] Git commits",
      },
      {
        "<leader>fgs",
        function() Snacks.picker.git_stash() end,
        desc = "[NAV] Git stash",
      },
      -- help
      {
        "<leader>fh",
        function() Snacks.picker.help() end,
        desc = "[NAV] Help tags",
      },
    },
    config = function(_, opts)
      require("snacks").setup(opts)

      local snacks = require("snacks")
      local silent_noremap = { silent = true, noremap = true, }

      -- User commands to mirror previous telescope commands
      vim.api.nvim_create_user_command("Builtins", function()
        snacks.picker.pickers()
      end, { bang = true, desc = "[NAV] Search snacks pickers", })

      vim.api.nvim_create_user_command("Commands", function()
        snacks.picker.commands()
      end, { bang = true, desc = "[NAV] Search commands", })

      vim.api.nvim_create_user_command("Mans", function()
        snacks.picker.man()
      end, { bang = true, desc = "[NAV] Search man pages", })

      vim.api.nvim_create_user_command("Maps", function()
        snacks.picker.keymaps()
      end, { bang = true, desc = "[NAV] Search keymaps", })

      vim.api.nvim_create_user_command("Marks", function()
        snacks.picker.marks()
      end, { bang = true, desc = "[NAV] Search marks", })

      vim.api.nvim_create_user_command("Tags", function()
        snacks.picker.tags()
      end, { bang = true, desc = "[NAV] Search tags", })
    end,
  },
}
