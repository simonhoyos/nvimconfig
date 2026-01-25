local opts = { silent = true, noremap = true, }

-- Neogit keybindings
vim.keymap.set("n", "<leader>gg", "<cmd>Neogit<CR>",
  vim.tbl_extend("force", opts, { desc = "[GIT] Neogit status", }))
vim.keymap.set("n", "<leader>gc", "<cmd>Neogit commit<CR>",
  vim.tbl_extend("force", opts, { desc = "[GIT] Neogit commit", }))
vim.keymap.set("n", "<leader>gl", "<cmd>Neogit log<CR>",
  vim.tbl_extend("force", opts, { desc = "[GIT] Neogit log", }))
vim.keymap.set("n", "<leader>gp", "<cmd>Neogit push<CR>",
  vim.tbl_extend("force", opts, { desc = "[GIT] Neogit push", }))

-- Gitsigns keybindings
-- These depend on gitsigns being loaded, but since we use after/plugin 
-- and it's a plugin that adds commands, we can use the plugin-specific functions
-- if we want to be safe or just use commands.
local gs = package.loaded.gitsigns

vim.keymap.set("n", "<leader>gh", function()
  if package.loaded.gitsigns then
    package.loaded.gitsigns.preview_hunk()
  end
end, vim.tbl_extend("force", opts, { desc = "[GIT] Preview hunk", }))

vim.keymap.set("n", "<leader>gb", function()
  if package.loaded.gitsigns then
    package.loaded.gitsigns.toggle_current_line_blame()
  end
end, vim.tbl_extend("force", opts, { desc = "[GIT] Toggle line blame", }))

vim.keymap.set("n", "<leader>gj", function()
  if package.loaded.gitsigns then
    if vim.wo.diff then return "]c" end
    vim.schedule(function() package.loaded.gitsigns.next_hunk() end)
    return "<Ignore>"
  end
end, { expr = true, desc = "[GIT] Next hunk", })

vim.keymap.set("n", "<leader>gk", function()
  if package.loaded.gitsigns then
    if vim.wo.diff then return "[c" end
    vim.schedule(function() package.loaded.gitsigns.prev_hunk() end)
    return "<Ignore>"
  end
end, { expr = true, desc = "[GIT] Previous hunk", })
