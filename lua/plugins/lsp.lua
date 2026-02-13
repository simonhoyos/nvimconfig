return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile", },
    dependencies = {
      { "williamboman/mason.nvim", opts = {}, },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "efm",

            "ts_ls",
            "tailwindcss",
            "eslint",
            "cssls",
            "html",
            "jsonls",

            "svelte",

            "ruby_lsp",
            "rubocop",

            -- "rust_analyzer",

            -- "pyright",
            -- "ruff",

            -- "graphql",
            "prismals",

            -- "dockerls",
            -- "docker_compose_language_service",
          },
        },
      },
      {
        "creativenull/efmls-configs-nvim",
        version = "v1.x.x",
      },
    },
  },
}
