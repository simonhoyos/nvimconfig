local neogit = package.loaded.neogit
local gitsigns = package.loaded.gitsigns

local opts = { silent = true, noremap = true, }

if neogit then
  vim.keymap.set("n", "<leader>gg", neogit.open,
    vim.tbl_extend("force", opts, { desc = "[GIT] Neogit status", }))
  vim.keymap.set("n", "<leader>gc", function() neogit.open({ "commit", }) end,
    vim.tbl_extend("force", opts, { desc = "[GIT] Neogit commit", }))
  vim.keymap.set("n", "<leader>gl", function() neogit.open({ "log", }) end,
    vim.tbl_extend("force", opts, { desc = "[GIT] Neogit log", }))
  vim.keymap.set("n", "<leader>gp", "<cmd>Neogit push<CR>",
    vim.tbl_extend("force", opts, { desc = "[GIT] Neogit push", }))
end

if gitsigns then
  vim.keymap.set("n", "<leader>gh", package.loaded.gitsigns.preview_hunk,
    vim.tbl_extend("force", opts, { desc = "[GIT] Preview hunk", }))
  vim.keymap.set("n", "<leader>gb",
    package.loaded.gitsigns.toggle_current_line_blame,
    vim.tbl_extend("force", opts,
      { desc = "[GIT] Toggle line blame", }))

  vim.keymap.set("n", "<leader>gj", function()
    if vim.wo.diff then
      return
        vim.cmd.normal({ "]c", bang = true, })
    end

    vim.schedule(gitsigns.next_hunk)

    return "<Ignore>"
  end, { expr = true, desc = "[GIT] Next hunk", })

  vim.keymap.set("n", "<leader>gk", function()
    if vim.wo.diff then
      return
        vim.cmd.normal({ "[c", bang = true, })
    end

    vim.schedule(gitsigns.prev_hunk)

    return "<Ignore>"
  end, { expr = true, desc = "[GIT] Previous hunk", })
end
