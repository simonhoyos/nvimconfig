return {
  {
    "vim-test/vim-test",
    config = function()
      local opts = { buffer = true, silent = true, noremap = true, }

      vim.g["test#strategy"] = "neovim"
      vim.g["test#neovim#term_position"] = "vertical"
      vim.g["test#neovim#start_normal"] = 1
      vim.g["test#basic#start_normal"] = 1

      vim.keymap.set("n", "<leader>tt", "<cmd>TestNearest<CR>",
        vim.tbl_extend("force", opts, { desc = "[TEST] Run nearest test", }))
      vim.keymap.set("n", "<leader>tf", "<cmd>TestFile<CR>",
        vim.tbl_extend("force", opts, { desc = "[TEST] Run all tests in file", }))
      vim.keymap.set("n", "<leader>ts", "<cmd>TestSuite<CR>",
        vim.tbl_extend("force", opts, { desc = "[TEST] Run test suite", }))
      vim.keymap.set("n", "<leader>tl", "<cmd>TestLast<CR>",
        vim.tbl_extend("force", opts, { desc = "[TEST] Run last run test", }))
      vim.keymap.set("n", "<leader>tv", "<cmd>TestVisit<CR>",
        vim.tbl_extend("force", opts, { desc = "[TEST] Visit test", }))

      -- let g:test#custom_strategies = {'jest': function('JestStrategy')}
      -- nnoremap <leader>dt :TestNearest -strategy=jest<CR>
      -- ]])
    end,
  },
}
