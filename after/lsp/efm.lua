local stylua = require("efmls-configs.formatters.stylua")

-- Custom prettier formatter that uses a relative path so efm-langserver
-- resolves it from its root directory (set via rootMarkers below).
-- This avoids efmls-configs' fs.executable() which only checks the
-- neovim cwd, breaking in monorepos where prettier is per-package.
local prettier = {
  formatCanRange = true,
  formatCommand = "node_modules/.bin/prettier --stdin --stdin-filepath '${INPUT}' ${--range-start:charStart} ${--range-end:charEnd} --config-precedence prefer-file",
  formatStdin = true,
}

local languages = {
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
    rootMarkers = {
      ".git/",
      ".prettierrc",
      ".prettierrc.json",
      ".prettierrc.js",
      ".prettierrc.yaml",
      ".prettierrc.yml",
      ".prettierrc.toml",
      ".prettierrc.json5",
      ".prettierrc.mjs",
      ".prettierrc.cjs",
      "prettier.config.js",
      "prettier.config.cjs",
      "prettier.config.mjs",
    },
    languages = languages,
  },
  filetypes = vim.tbl_keys(languages),
}
