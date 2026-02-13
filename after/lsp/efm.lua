local prettier = require("efmls-configs.formatters.prettier")
local stylua = require("efmls-configs.formatters.stylua")
-- local eslint = require('efmls-configs.linters.eslint')

local languages = {
  -- javascript = { prettier, eslint },
  -- javascriptreact = { prettier, eslint },
  -- typescript = { prettier, eslint },
  -- typescriptreact = { prettier, eslint },

  javascript = { prettier, },
  javascriptreact = { prettier, },
  typescript = { prettier, },
  typescriptreact = { prettier, },

  css = { prettier, },
  scss = { prettier, },
  html = { prettier, },
  json = { prettier, },
  yaml = { prettier, },
  yml = { prettier, },
  markdown = { prettier, },

  lua = { stylua, },
}

return {
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
    hover = true,
    documentSymbol = true,
    codeAction = true,
    completion = true,
  },
  settings = {
    rootMarkers = { ".git/", },
    languages = languages,
  },
  filetypes = vim.tbl_keys(languages),
}
