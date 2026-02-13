local system = require("lib.system")

-- Core Editor Options
-- disable builtins
vim.g.loaded_matchit = 1
vim.g.loaded_matchparen = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.opt.mouse = ""

-- UI & Visuals
vim.opt.number = true
vim.opt.numberwidth = 1
vim.opt.relativenumber = true
vim.opt.signcolumn = "yes"
vim.opt.shortmess:append({ c = true, })
vim.opt.colorcolumn = "+1"
vim.opt.laststatus = 2
vim.opt.showmode = false
vim.opt.winbar = "%=%m%r %f "

-- Indentation & Formatting
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2

vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.cindent = true

vim.opt.wrap = false

vim.opt.encoding = "utf-8"
vim.opt.listchars = {
  eol = "¬",
  space = "·",
  tab = ">-",
  trail = "~",
  extends = ">",
  precedes = "<",
}

-- fold
vim.opt.textwidth = 120
vim.opt.fillchars = {
  fold = " ",
  foldopen = "-",
}
vim.opt.foldlevel = 999
vim.wo.foldmethod = "expr"

-- Search Behavior
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.rtp:append("/usr/local/opt/fzf")

-- Window Management
vim.opt.splitbelow = true
vim.opt.splitright = true
vim.opt.startofline = false

-- System & Files
vim.opt.scrolloff = 8
vim.opt.swapfile = false
vim.opt.hidden = true
vim.opt.backupdir = system.get_backup_dir()
vim.opt.backupcopy = "yes"
vim.opt.undofile = true
vim.opt.updatetime = 300
vim.opt.timeoutlen = 300

-- spellcheck
vim.opt.spell = true
vim.opt.spelllang = "en_us"
vim.opt.spelloptions = "camel"
vim.opt.spellcapcheck = ""

-- expand ignore
vim.opt.wildignore:append("*.bin, *.dll, *.exe")
vim.opt.wildignore:append("*/.git/*, */.svn/*, */build/**, */dist/**")
vim.opt.wildignore:append(
  "*.jpg, *.png, *.jpeg, *.bmp, *.gif, *.tiff, *.svg, *.ico")
vim.opt.wildignore:append(
  "*.DS_Store, *.aux, *.bbl, *.blg, *.brf, *.fls, *.fdb_latexmk, *.synctex.gz, *.xdv")
vim.opt.wildignorecase = true

-- highlights
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
