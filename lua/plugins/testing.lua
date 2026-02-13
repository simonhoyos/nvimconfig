return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
      "marilari88/neotest-vitest",
    },
    config = function()
      require("neotest").setup({
        adapters = {
          require("neotest-rspec"),
          require("neotest-vitest"),
        },
      })

      local opts = { silent = true, noremap = true, }

      vim.keymap.set("n", "<leader>tt",
        function() require("neotest").run.run() end,
        vim.tbl_extend("force", opts, { desc = "[TEST] Run nearest test", }))
      vim.keymap.set("n", "<leader>tf",
        function() require("neotest").run.run(vim.fn.expand("%")) end,
        vim.tbl_extend("force", opts, { desc = "[TEST] Run all tests in file", }))
      vim.keymap.set("n", "<leader>ts",
        function() require("neotest").run.run(vim.fn.getcwd()) end,
        vim.tbl_extend("force", opts, { desc = "[TEST] Run test suite", }))
      vim.keymap.set("n", "<leader>tl",
        function() require("neotest").run.run_last() end,
        vim.tbl_extend("force", opts, { desc = "[TEST] Run last run test", }))
      vim.keymap.set("n", "<leader>tv",
        function() require("neotest").summary.toggle() end,
        vim.tbl_extend("force", opts, { desc = "[TEST] Toggle summary", }))
      vim.keymap.set("n", "<leader>to",
        function() require("neotest").output.open({ enter = true, }) end,
        vim.tbl_extend("force", opts, { desc = "[TEST] Open test output", }))
    end,
  },
}
