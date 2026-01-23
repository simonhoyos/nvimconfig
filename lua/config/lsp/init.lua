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
  local keymaps = require("config.lsp.keymaps")
  local server_opts = require("config.lsp.servers").opts
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")

  local on_attach = function(client, bufnr)
    keymaps.on_attach(client, bufnr)
    setup_format_on_save(client, bufnr)
  end

  local capabilities = vim.lsp.protocol.make_client_capabilities()

  mason_lspconfig.setup_handlers({
    function(server_name)
      local opts = server_opts[server_name] or {}
      opts.on_attach = on_attach
      opts.capabilities = capabilities
      lspconfig[server_name].setup(opts)
    end,
  })
end

function M.setup()
  setup_mason()
  setup_servers()
end

return M
