-- map('n', '<leader>ln', '<cmd>lua require("follow-md-links").follow_link()<cr>')
-- map('n', '<leader>lb', '<cmd>edit #<cr>')

vim.keymap.set("n", "<space>guid", function()
  local guid = vim.fn.expand("%:t:r")

  vim.api.nvim_put({ guid, }, "c", false, true)
end)

local textwidth = 100

vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, buffer = true, })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, buffer = true, })

-- vim.opt_local.formatoptions = '1'
-- vim.opt_local.formatoptions = 't'

-- vim.opt_local.formatoptions:append('t')
-- vim.opt_local.formatoptions:remove('1')

-- vim.opt_local.columns = textwidth

vim.opt_local.wrap = true
vim.opt_local.linebreak = false
-- vim.opt_local.textwidth = 0
-- vim.opt_local.wrapmargin = vim.api.nvim_win_get_width(0) - textwidth
-- vim.opt_local.wrapmargin = 20

vim.opt_local.autoindent = false
vim.opt_local.shiftwidth = 5
vim.opt_local.tabstop = 5
vim.opt_local.expandtab = false

vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us,es_es"

vim.opt_local.spellcapcheck = "[.?!]\\_[\\])'\" \\t]'"

vim.opt_local.thesaurus = "/Users/simonhoyos/.vim/thesaurus/mthesaur.txt"
vim.opt_local.complete:append("s")

-- [s ]s to navigate through spelling checks
-- z= -> show replacements
-- zg -> mark as correct
-- zw -> mark as incorrect

-- local group = vim.api.nvim_create_augroup('text_edit', { clear = false })
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = '*.md',
--   group = group,
--   desc = '[text_edit] word processor',
--   callback = word_processor,
-- })
