local navigation = require("lib.navigation")

vim.g.netrw_liststyle = 0
vim.g.netrw_keepdir = 1
vim.g.netrw_winsize = 30
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_list_hide = vim.call("netrw_gitignore#Hide"):gsub(".env[.%a+]*", "") ..
  ",.git/"

vim.keymap.set("n", "%", navigation.create_file,
  { silent = true, noremap = true, buffer = true })
