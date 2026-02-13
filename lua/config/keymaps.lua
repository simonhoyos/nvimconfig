local navigation = require("lib.navigation")
local path = require("lib.path")

local opts = { silent = true, noremap = true, }

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

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("n", "<leader>pp", path.copy_relative_path)
vim.keymap.set("n", "<leader>pa", path.copy_absolute_path)
vim.keymap.set("n", "<leader>pg", path.copy_remote_link)
