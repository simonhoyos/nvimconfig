vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true, }),
  desc = "[Editing] Highlight when yanking text",
  callback = function()
    vim.highlight.on_yank()
  end,
})
