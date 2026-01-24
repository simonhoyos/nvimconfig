local M = {}

local netrw_is_open = 0

--- Closes the last netrw buffer
local function close_last_netrw()
  local last_buffer = vim.fn.bufnr("$")

  while last_buffer >= 1 do
    if vim.fn.getbufvar(last_buffer, "&filetype") == "netrw" then
      vim.fn.execute("bwipeout " .. last_buffer, "silent")
    end

    last_buffer = last_buffer - 1
  end
end

--- Toggles the netrw file explorer
function M.toggle_netrw()
  if netrw_is_open > 0 then
    close_last_netrw()

    netrw_is_open = 0
  else
    netrw_is_open = 1

    vim.fn.execute("Lexplore", "silent")
  end
end

--- Toggles the netrw file explorer to the current file directory
function M.toggle_netrw_current_file()
  if netrw_is_open > 0 then
    close_last_netrw()

    netrw_is_open = 0
  else
    netrw_is_open = 1

    vim.fn.execute("Lexplore %:p:h", "silent")
  end
end

--- Creates a new file in the current netrw directory
function M.create_file()
  local path = vim.fn.expand("%")
  local file = vim.fn.input("Enter filename: ")

  if file ~= "" then
    local file_path = ""

    if path ~= "" then
      file_path = path .. "/"
    end

    file_path = file_path .. file

    vim.fn.system("touch " .. file_path)

    vim.cmd("vsplit")

    local win = vim.api.nvim_get_current_win()
    local buf = vim.api.nvim_create_buf(true, true)

    vim.api.nvim_win_set_buf(win, buf)
    vim.cmd("e " .. file_path)

    close_last_netrw()
  end
end

return M
