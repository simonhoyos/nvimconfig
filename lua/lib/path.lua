local system = require("lib.system")

local M = {}

--- Copy the relative path of the current file to clipboard
function M.copy_relative_path()
  local path = vim.fn.expand("%")

  vim.api.nvim_echo({ { path, }, }, false, {})

  vim.fn.setreg("+", path, "c")
end

--- Copy the absolute path of the current file to clipboard
function M.copy_absolute_path()
  local path = vim.fn.expand("%:p")

  vim.api.nvim_echo({ { path, }, }, false, {})

  vim.fn.setreg("+", path, "c")
end

--- Copy perma link to the current file in the remote repository to clipboard
function M.copy_remote_link()
  local is_git_repo = not string.find(
  system.run_shell_command("git status 2>&1", false), "fatal")

  if is_git_repo then
    local is_git_file = false

    local root_dir = system.run_shell_command("git rev-parse --show-toplevel",
      false)
    local file_dir = vim.fn.expand("%:p")
    local files = system.run_shell_command("git ls-files --full-name", true)
    local file_name = ""

    for file in files do
      local abs_path = root_dir .. "/" .. file

      if abs_path == file_dir then
        is_git_file = true
        file_name = file
      end
    end

    if is_git_file then
      local line = vim.fn.line(".")
      local hash = system.run_shell_command("git rev-parse HEAD", false)
      local url = system.run_shell_command("git config --get remote.origin.url",
        false)
      local path = system.split_string(url, ":", 2)

      path = "https://github.com/" ..
      path:gsub(".git", "") ..
      "/blob/" .. hash .. "/" .. file_name .. "#L" .. line

      vim.api.nvim_echo({ { path, }, }, false, {})

      vim.fn.setreg("+", path, "c")
    else
      vim.api.nvim_echo({
        { "This file is not tracked in the remote repo", "WarningMsg", },
        { "\nPress any key to exit...", },
      }, true, {})
    end
  else
    vim.api.nvim_echo({
      { "Oops, this is not a git repo", "ErrorMsg", },
      { "\nPress any key to exit...", },
    }, true, {})
  end
end

return M
