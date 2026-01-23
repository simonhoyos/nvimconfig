local M = {}

local function setup_mason()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" },
    automatic_installation = true,
  })
end

local function setup_servers()
  local lspconfig = require("lspconfig")
  -- We will configure servers here later
end

setup_mason()
setup_servers()

return M
