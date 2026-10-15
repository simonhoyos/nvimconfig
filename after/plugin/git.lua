local neogit = package.loaded.neogit
local gitsigns = package.loaded.gitsigns

local palette = require("lib.palette")

local function neogit_diff_highlights()
  local blend = palette.blend
  local normal_bg = palette.bg
  local normal_fg = palette.fg
  local red = palette.red
  local green = palette.green
  local blue = palette.cyan
  local purple = palette.purple
  local grey = palette.comment

  local bg_green = blend(green, normal_bg, 0.15)
  local bg_red = blend(red, normal_bg, 0.15)
  local bg_green_hl = blend(green, normal_bg, 0.25)
  local bg_red_hl = blend(red, normal_bg, 0.25)
  local bg_context = blend(normal_fg, normal_bg, 0.06)

  local hl = vim.api.nvim_set_hl
  -- Context lines: keep the editor background so added/removed lines pop.
  hl(0, "NeogitDiffContext",          { bg = "NONE", fg = normal_fg })
  hl(0, "NeogitDiffContextHighlight", { bg = bg_context, fg = normal_fg })
  hl(0, "NeogitDiffContextCursor",    { bg = bg_context, fg = normal_fg })

  hl(0, "NeogitDiffAdd",              { bg = bg_green, fg = green })
  hl(0, "NeogitDiffAddHighlight",     { bg = bg_green_hl, fg = green })
  hl(0, "NeogitDiffAddCursor",        { bg = bg_green_hl, fg = green })
  hl(0, "NeogitDiffAdditions",        { fg = green })
  hl(0, "NeogitDiffAddInline",        { bg = blend(green, normal_bg, 0.45), fg = normal_fg, bold = true })

  hl(0, "NeogitDiffDelete",           { bg = bg_red, fg = red })
  hl(0, "NeogitDiffDeleteHighlight",  { bg = bg_red_hl, fg = red })
  hl(0, "NeogitDiffDeleteCursor",     { bg = bg_red_hl, fg = red })
  hl(0, "NeogitDiffDeletions",        { fg = red })
  hl(0, "NeogitDiffDeleteInline",     { bg = blend(red, normal_bg, 0.45), fg = normal_fg, bold = true })

  hl(0, "NeogitHunkHeader",           { bg = blend(grey, normal_bg, 0.25), fg = normal_fg, bold = true })
  hl(0, "NeogitHunkHeaderHighlight",  { bg = purple, fg = normal_bg, bold = true })
  hl(0, "NeogitHunkHeaderCursor",     { bg = purple, fg = normal_bg, bold = true })

  hl(0, "NeogitDiffHeader",           { bg = blend(grey, normal_bg, 0.15), fg = blue, bold = true })
  hl(0, "NeogitDiffHeaderHighlight",  { bg = blend(grey, normal_bg, 0.25), fg = blue, bold = true })
end

neogit_diff_highlights()

vim.api.nvim_create_autocmd("ColorScheme", {
  group = vim.api.nvim_create_augroup("NeogitDiffHighlights", { clear = true, }),
  desc = "[GIT] Re-apply Neogit diff highlights",
  callback = neogit_diff_highlights,
})

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
