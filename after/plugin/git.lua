local neogit = package.loaded.neogit
local gitsigns = package.loaded.gitsigns

do
  local function get_hex(group, attr)
    local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
    return hl and hl[attr] and string.format("#%06x", hl[attr])
  end

  local function blend(color, bg, alpha)
    local function ch(c, b)
      return string.format("%02x", math.floor(c * alpha + b * (1 - alpha)))
    end
    return "#"
      .. ch(tonumber(color:sub(2, 3), 16), tonumber(bg:sub(2, 3), 16))
      .. ch(tonumber(color:sub(4, 5), 16), tonumber(bg:sub(4, 5), 16))
      .. ch(tonumber(color:sub(6, 7), 16), tonumber(bg:sub(6, 7), 16))
  end

  local normal_bg = get_hex("Normal", "bg") or "#000000"
  local red = get_hex("Error", "fg") or "#ff5555"
  local green = get_hex("Type", "fg") or "#50fa7b"

  local dim_bg_green = blend(green, normal_bg, 0.15)
  local dim_bg_red = blend(red, normal_bg, 0.15)

  local hl = vim.api.nvim_set_hl
  hl(0, "NeogitDiffAdd",              { bg = dim_bg_green, fg = green })
  hl(0, "NeogitDiffDelete",           { bg = dim_bg_red, fg = red })
  hl(0, "NeogitDiffAddHighlight",     { bg = dim_bg_green, fg = green })
  hl(0, "NeogitDiffDeleteHighlight",  { bg = dim_bg_red, fg = red })
  hl(0, "NeogitDiffAddInline",        { bg = green, fg = normal_bg })
  hl(0, "NeogitDiffDeleteInline",     { bg = red, fg = normal_bg })
end

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
