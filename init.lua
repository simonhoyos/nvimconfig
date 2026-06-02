require("lib.ensure_lazy").run()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")

local spec = {
  { import = "plugins", },
}

-- Load local (machine/work-specific) plugins if the directory exists.
-- Files in lua/plugins/local/ are gitignored and never committed.
local local_plugins_path = vim.fn.stdpath("config") .. "/lua/plugins/local"
if vim.fn.isdirectory(local_plugins_path) == 1 then
  table.insert(spec, { import = "plugins.local", })
end

require("lazy").setup({
  spec = spec,
  install = { colorscheme = { "dracula", }, },
})
