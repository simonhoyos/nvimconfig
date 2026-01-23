local M = {}

local function setup_mason()
  require("mason").setup()
  require("mason-lspconfig").setup({
    ensure_installed = { "lua_ls" },
    automatic_installation = true,
  })
end

local function setup_format_on_save(client, bufnr)
  if client.supports_method("textDocument/formatting") then
    local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
end

local function setup_servers()
  local keymaps = require("plugins.lsp.keymaps")
  local servers = require("plugins.lsp.servers")

  local on_attach = function(client, bufnr)
    keymaps.on_attach(client, bufnr)
    setup_format_on_save(client, bufnr)
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  servers.setup(on_attach, capabilities)
end

function M.setup()
  setup_mason()
  setup_servers()
end

return M