local string_utils = require("lib.strings")

local M = {}

---
--- Run a shell command and return the output
---
--- @param cmd string shell command to run
--- @param is_multiline_stdout boolean whether the output is multiline
--- @return string result of the shell command
function M.run_shell_command(cmd, is_multiline_stdout)
  local f = assert(io.popen(cmd, "r"))

  if is_multiline_stdout then
    return f:lines()
  else
    local s = assert(f:read("*a"))
    f:close()

    return string_utils.string_strip_whitespace(s)
  end
end

---
--- Get the backup directory
---
--- @return string backup directory
function M.get_backup_dir()
  local backup_directory = vim.fn.expand(vim.fn.stdpath("data"), "/backup")

  if not vim.fn.isdirectory(backup_directory) then
    vim.fn.mkdir(backup_directory, "p")
  end

  return backup_directory
end

function M.split_string(str, delimiter, index)
  local pattern = "([^" .. delimiter .. "]+)"
  local result = {}

  for word in string.gmatch(str, pattern) do
    table.insert(result, word)
  end

  return result[index]
end

return M
