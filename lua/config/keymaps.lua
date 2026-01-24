local navigation = require("lib.navigation")

local opts = { silent = true, noremap = true, }

vim.keymap.set("n", "<leader>nn", navigation.toggle_netrw, opts)
vim.keymap.set("n", "<leader>nc", navigation.toggle_netrw_current_file, opts)
vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>", opts)
