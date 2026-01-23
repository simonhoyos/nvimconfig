vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = "rounded",
})

vim.lsp.handlers["textDocument/signatureHelp"] =
  vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded", })

vim.diagnostic.config({
  virtual_text = {
    spacing = 4,
    prefix = "●",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "E",
      [vim.diagnostic.severity.WARN] = "W",
      [vim.diagnostic.severity.HINT] = "H",
      [vim.diagnostic.severity.INFO] = "I",
    },
    numhl = {
      [vim.diagnostic.severity.ERROR] = "ErrorMsg",
      [vim.diagnostic.severity.WARN] = "WarningMsg",
    },
  },
  underline = true,
  severity_sort = true,
  float = {
    border = "rounded",
  },
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = false, })

vim.api.nvim_create_autocmd("LspAttach", {
  group = augroup,
  desc = "[LSP] lsp on attach",
  callback = function(ev)
    -- TODO: add keymaps here
  end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
  group = augroup,
  desc = "[LSP] lsp format on save",
  callback = function()
    vim.lsp.buf.format({
      async = false,
      timeout_ms = 10000,

      filter = function(client)
        local filetype = vim.bo.filetype
        local formatter = ({
          lua_ls = {
            -- TODO: add to the documentation to add stylua using mason
            "lua",
          },
        })[client.name]

        return vim.tbl_contains(formatter or {}, filetype)
      end,
    })
  end,
})


vim.api.nvim_create_user_command("LspInfo", function()
  local clients = vim.lsp.get_clients({ bufnr = 0, })

  if #clients == 0 then
    print("No LSP clients attached to current buffer")
    return
  end

  print("Attached LSP clients:")
  for _, client in ipairs(clients) do
    print(string.format("  - %s (id: %d)", client.name, client.id))
  end
end, {
  desc = "[LSP] Print attached LSP clients for current buffer",
})
