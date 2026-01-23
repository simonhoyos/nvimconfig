local M = {}

function M.on_attach(client, bufnr)
  local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, buffer = bufnr, desc = "[LSP] " .. desc })
  end

  map("n", "<leader>lh", vim.lsp.buf.hover, "Hover Documentation")
  map("n", "<leader>ld", vim.lsp.buf.definition, "Go to Definition")
  map("n", "<leader>lD", vim.lsp.buf.declaration, "Go to Declaration")
  map("n", "<leader>li", vim.lsp.buf.implementation, "Go to Implementation")
  map("n", "<leader>lt", vim.lsp.buf.type_definition, "Go to Type Definition")
  map("n", "<leader>lr", vim.lsp.buf.rename, "Rename Symbol")
  map("n", "<leader>la", vim.lsp.buf.code_action, "Code Action")
  map("n", "<leader>lR", vim.lsp.buf.references, "Find References")
  map("n", "<leader>ls", vim.lsp.buf.signature_help, "Signature Help")
  map("n", "<leader>lf", function()
    vim.lsp.buf.format({ async = true })
  end, "Format Buffer")

  map("n", "<leader>lj", vim.diagnostic.goto_next, "Next Diagnostic")
  map("n", "<leader>lk", vim.diagnostic.goto_prev, "Previous Diagnostic")
  map("n", "<leader>ll", vim.diagnostic.setloclist, "List Diagnostics")
end

return M
