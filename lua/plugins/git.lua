return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "sindrets/diffview.nvim",
      "folke/snacks.nvim",
    },
    opts = function()
      local palette = require("lib.palette")

      return {
        disable_commit_confirmation = true,
        integrations = {
          diffview = true,
          snacks = true,
        },
        -- Neogit builds its palette from semantic groups by default, which
        -- Dracula does not map to matching colors. Give it the real ones.
        highlight = {
          red = palette.red,
          orange = palette.orange,
          yellow = palette.yellow,
          green = palette.green,
          cyan = palette.cyan,
          blue = palette.purple,
          purple = palette.pink,
        },
      }
    end,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "│", },
        change = { text = "│", },
        delete = { text = "_", },
        topdelete = { text = "‾", },
        changedelete = { text = "~", },
        untracked = { text = "┆", },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = {
        interval = 1000,
        follow_files = true,
      },
      attach_to_untracked = true,
      current_line_blame = false,
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil,
      max_file_length = 40000,
      preview_config = {
        border = "single",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    config = true,
  },
}
