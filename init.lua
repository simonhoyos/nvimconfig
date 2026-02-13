require("lib.ensure_lazy").run()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")
require("config.keymaps")

require("lazy").setup({
  spec = { import = "plugins", },
  install = { colorscheme = { "dracula", }, },
})
