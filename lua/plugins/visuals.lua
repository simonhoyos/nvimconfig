return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    main = "ibl",
    opts = {},
  },
  {
    "levouh/tint.nvim",
    event = "VeryLazy",
    opts = {
      filter = function(winid)
        local bufid = vim.api.nvim_win_get_buf(winid)
        -- Exclude floating windows
        if vim.api.nvim_get_option_value("buftype", { buf = bufid }) == "floating" then
          return false
        end
        -- Exclude Neo-tree
        if vim.api.nvim_get_option_value("filetype", { buf = bufid }) == "neo-tree" then
          return false
        end
        return true
      end,
    },
  },
  {
    "folke/twilight.nvim",
    cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
    opts = {},
  },
  {
    "szw/vim-maximizer",
    keys = {
      { "<leader>m", "<cmd>MaximizerToggle<CR>", desc = "Maximize Window" },
    },
  },
}
