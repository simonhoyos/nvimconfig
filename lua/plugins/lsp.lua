return {
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "williamboman/mason.nvim", opts = {} },
      {
        "williamboman/mason-lspconfig.nvim",
        opts = {
          ensure_installed = {
            "lua_ls",
            "efm",
          },
        }
      },
      {
        'creativenull/efmls-configs-nvim',
        version = 'v1.x.x',
      },
    },
  },
}
