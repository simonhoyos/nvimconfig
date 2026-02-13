return {
  {
    "jghauser/follow-md-links.nvim",
    ft = "markdown",
  },
  {
    "ellisonleao/carbon-now.nvim",
    lazy = true,
    cmd = "CarbonNow",
    opts = {
      options = {
        bg = "rgba(0,0,0,0)",
        font_family = "Fira Code",
        theme = "one-dark",
        titlebar = "simonhoyos",
        window_theme = "none",
      },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    enabled = false,
  },
  {
    "dstein64/vim-startuptime",
    cmd = "StartupTime",
    init = function()
      vim.g.startuptime_tries = 10
    end,
    enabled = false,
  },
}
