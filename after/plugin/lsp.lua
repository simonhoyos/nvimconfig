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
    local opts = { buffer = ev.buf, silent = true, noremap = true, }

    vim.keymap.set("n", "<leader>lh", vim.lsp.buf.hover,
      vim.tbl_extend("force", opts, { desc = "[LSP] Hover documentation", }))
    vim.keymap.set("n", "<leader>ls", vim.lsp.buf.signature_help,
      vim.tbl_extend("force", opts, { desc = "[LSP] Signature help", }))
    vim.keymap.set("n", "<leader>ld", vim.lsp.buf.definition,
      vim.tbl_extend("force", opts, { desc = "[LSP] Go to definition", }))
    vim.keymap.set("n", "<leader>lD", vim.lsp.buf.declaration,
      vim.tbl_extend("force", opts, { desc = "[LSP] Go to declaration", }))
    vim.keymap.set("n", "<leader>lt", vim.lsp.buf.type_definition,
      vim.tbl_extend("force", opts, { desc = "[LSP] Go to type definition", }))
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.references,
      vim.tbl_extend("force", opts, { desc = "[LSP] List references", }))
    vim.keymap.set("n", "<leader>li", vim.lsp.buf.implementation,
      vim.tbl_extend("force", opts, { desc = "[LSP] Go to implementation", }))
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename,
      vim.tbl_extend("force", opts, { desc = "[LSP] Rename symbol", }))
    vim.keymap.set({ "n", "x", }, "<leader>lf",
      function() vim.lsp.buf.format({ async = true, }) end,
      vim.tbl_extend("force", opts, { desc = "[LSP] Format buffer", }))
    vim.keymap.set({ "n", "x", }, "<leader>lx", vim.lsp.buf.code_action,
      vim.tbl_extend("force", opts, { desc = "[LSP] Code action", }))
    vim.keymap.set("n", "<leader>ldl", vim.diagnostic.open_float,
      vim.tbl_extend("force", opts, { desc = "[LSP] Open diagnostic float", }))
    vim.keymap.set("n", "<leader>ldj",
      function() vim.diagnostic.jump({ count = 1, severity = { min = vim.diagnostic.severity.WARN, }, }) end,
      vim.tbl_extend("force", opts,
        { desc = "[LSP] Jump to next diagnostic (Skip HINT)", }))
    vim.keymap.set("n", "<leader>ldk",
      function() vim.diagnostic.jump({ count = -1, severity = { min = vim.diagnostic.severity.WARN, }, }) end,
      vim.tbl_extend("force", opts,
        { desc = "[LSP] Jump to previous diagnostic (Skip HINT)", }))
    vim.keymap.set("n", "<leader>ldq", vim.diagnostic.setloclist,
      vim.tbl_extend("force", opts,
        { desc = "[LSP] Add diagnostics to quick fix list", }))
    vim.keymap.set("n", "<leader>ldy",
      function()
        vim.diagnostic.open_float()
        vim.diagnostic.open_float()

        local win_id = vim.fn.win_getid()

        vim.cmd("normal! j")
        vim.cmd("normal! VG")
        vim.cmd('normal! "+y')

        vim.api.nvim_win_close(win_id, true)
      end,
      vim.tbl_extend("force", opts,
        { desc = "[LSP] yank current line diagnostics", }))
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
          -- rust_analyzer = { 'rust' },
          prismals = { "prisma", },
          ruff = { "python", },
          efm = {
            "javascript",
            "javascriptreact",
            "typescript",
            "typescriptreact",

            "json",
            "markdown",

            "lua",
          },
          ruby = {
            "rubocop",
          },
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
