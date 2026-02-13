vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true, }),
  desc = "[Editing] Highlight when yanking text",
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", }, {
  group = vim.api.nvim_create_augroup("spell_ignore_group", { clear = true, }),
  desc = "[Spell] add custom spell ignore",
  callback = function()
    vim.cmd([[
      syn spell toplevel
      syn match UuidNoSpell /\v[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/ containedin=ALL
      syn match HexNoSpell /\v#[0-9a-fA-F]{3,6}/ containedin=ALL
      syn match Md5NoSpell /\v[0-9a-fA-F]{64}/ containedin=ALL
      syn match DpathNoSpell /\vd="[^"]*"/ containedin=ALL
      " UrlNoSpell
      syn cluster Spell add=UuidNoSpell,HexNoSpell,Md5NoSpell,UrlNoSpell,DpathNoSpell
    ]])
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = vim.api.nvim_create_augroup("trail_whitespace", { clear = false, }),
  desc = "[Editor] Remove trailing whitespace (trailertrash.vim)",
  command = "TrailerTrim",
})
