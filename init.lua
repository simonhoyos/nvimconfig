require("lib.ensure_lazy").run()

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("config.options")

require("lazy").setup()

