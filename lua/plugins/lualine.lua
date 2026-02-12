return {
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons", },
    opts = {
      options = {
        icons_enabled = true,
        theme = "dracula",
        component_separators = { left = "", right = "", },
        section_separators = { left = "", right = "", },
        disabled_filetypes = {},
        always_divide_middle = true,
      },
      sections = {
        lualine_a = { "mode", },
        lualine_b = { "branch", "diff", },
        lualine_c = { "filename", },
        lualine_x = {
          "encoding",
          "fileformat",
          {
            "diagnostics",
            sources = { "nvim_diagnostic", },
            symbols = { error = " ", warn = " ", info = " ", hint = " ", },
          },
        },
        lualine_y = { "filetype", },
        lualine_z = { "%l/%L", "%c", },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename", },
        lualine_x = { "location", },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
    },
  },
}
