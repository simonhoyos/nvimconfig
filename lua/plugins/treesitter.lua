return {
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").install({
        "typescript",
        "javascript",
        "tsx",
        "ruby",
        "html",
        "haml",
        "css",
        "scss",
        "svelte",
        "lua",
        "json",
        "yaml",
        "toml",
        "markdown",
        "markdown_inline",
        "bash",
        "sql",
        "vim",
        "vimdoc",
        "query",
      })

      local group = vim.api.nvim_create_augroup("TreesitterSetup", { clear = true })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        desc = "[SYN] Enable treesitter highlighting",
        callback = function()
          pcall(vim.treesitter.start)
        end,
      })

      vim.api.nvim_create_autocmd("FileType", {
        group = group,
        desc = "[SYN] Enable treesitter indentation",
        callback = function()
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
      })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      max_lines = 5,
      separator = nil,
    },
  },
}
