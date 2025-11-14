local M = {}

local config = {
  path = 'lazy/lazy.nvim',
  git_repository_url = 'https://github.com/folke/lazy.nvim.git',
}

function M.run(opts)
  vim.tbl_deep_extend('force', config, opts or {})

  local lazy_path = vim.fn.stdpath('data') .. config.path

  if not (vim.uv or vim.loop).fs_stat(lazy_path) then
    local out = vim.fn.system({
      'git',
      'clone',
      '--filter=blob:none',
      '--branch=stable',
      config.git_repository_url,
      lazy_path,
    })

    if vim.v.shell_error ~= 0 then
      vim.api.nvim_echo({
        { 'Failed to clone lazy.nvim:\n', 'ErrorMsg' },
        { out, 'WarningMsg' },
        { '\nPress any key to exit...' },
      }, true, {})

      vim.fn.getchar()

      os.exit(1)
    end
  end

  vim.opt.rtp:prepend(lazy_path)
end

return M