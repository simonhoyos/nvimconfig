local languages = {
  lua = {
    stylua = require("efmls-configs.formatters.stylua"),
  },
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
