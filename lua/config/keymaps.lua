local navigation = require("lib.navigation")

local opts = { silent = true, noremap = true, }

vim.cmd.syntax("on")
vim.cmd.highlight("CursorColumn ctermbg=3")
vim.cmd([[hi! link netrwMarkFile Search]])

-- Remap
vim.keymap.set("v", "<leader>p", '"_dP')
vim.keymap.set("n", "<leader>y", '"+y')
vim.keymap.set("v", "<leader>y", '"+y')
vim.keymap.set("n", "<leader>Y", '"+Y', { noremap = false, })
vim.keymap.set("n", "<leader>d", '"_d')
vim.keymap.set("v", "<leader>d", '"_d')
vim.keymap.set("n", "<leader>D", '"_D')

vim.keymap.set("v", "/", "<Esc>/\\%V")

vim.keymap.set("n", "<leader>j", ":m .+1<cr>==")
vim.keymap.set("n", "<leader>k", ":m .-2<cr>==")
vim.keymap.set("v", "<leader>j", ":m '>+1<cr>gv=gv")
vim.keymap.set("v", "<leader>k", ":m '<-2<cr>gv=gv")

vim.keymap.set("n", "<leader>r", '"+y:%s/<c-r>+//gc<left><left><left>')
vim.keymap.set("v", "<leader>r", ":%s/<c-r><c-w>//gc<left><left><left>")

vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "<", "<gv")

vim.keymap.set("n", "<leader>hl", "<cmd>set hls!<cr>")
vim.keymap.set("n", "<leader>rn", "<cmd>set rnu!<cr>")
vim.keymap.set("n", "<leader>cuc", "<cmd>set cursorcolumn!<cr>")

vim.keymap.set("n", "J", "mzJ`z")

vim.keymap.set("n", "<leader>nn", navigation.toggle_netrw, opts)
vim.keymap.set("n", "<leader>nc", navigation.toggle_netrw_current_file, opts)
vim.keymap.set("n", "<leader>cd", "<cmd>cd %:p:h<CR>", opts)
