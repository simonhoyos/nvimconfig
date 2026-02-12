return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile", },
    main = "ibl",
    opts = {},
  },
  {
    -- TODO: archived repository. Look for alternatives
    "levouh/tint.nvim",
    event = "VeryLazy",
    opts = {
      tint = 0,
      saturation = 0.2,
      filter = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)

        if vim.api.nvim_get_option_value("buftype", { buf = bufid, }) == "floating" then
          return false
        end

        return true
      end,
    },
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable", },
    opts = {
      dimming = {
        alpha = 0.25,
        color = { "Normal", "#ffffff", },
        inactive = false,
      },
      context = 0,
      treesitter = true,
      expand = {
        "function",
        "method",
        "table",
        "if_statement",
      },
      exclude = {},
    },
  },
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>m", "<cmd>MaximizerToggle<CR>", desc = "Maximize Window", },
    },
  },
}
