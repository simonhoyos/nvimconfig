-- Core Editor Options

-- disable builtins
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.opt.mouse = ""

-- UI & Visuals
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.signcolumn = "yes"

-- Indentation & Formatting
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Search Behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Window Management
vim.opt.splitbelow = true
vim.opt.splitright = true

-- System & Files
vim.opt.undofile = true
vim.opt.clipboard = "unnamedplus"
vim.opt.scrolloff = 8
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300

vim.cmd.syntax("on")
vim.cmd.highlight("CursorColumn ctermbg=3")
vim.cmd.highlight("UnwantedTrailerTrash guibg=#d75f5f guifg=IndianRed")
vim.cmd([[hi! link netrwMarkFile Search]])

-- match colors with terminal
if vim.fn.has("termguicolors") then
  vim.opt.termguicolors = true
end

if not vim.fn.has("gui_running") then
  vim.opt.t_Co = 256
end
