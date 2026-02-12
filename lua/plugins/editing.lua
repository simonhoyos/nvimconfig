return {
  {
    "tpope/vim-surround",
    event = "VeryLazy",
  },
  {
    "tpope/vim-repeat",
    event = "VeryLazy",
  },
  {
    "andymass/vim-matchup",
    event = { "BufReadPost", "BufNewFile", },
    -- FIX: workaround for cmp issue
    -- https://github.com/hrsh7th/nvim-cmp/issues/1940
    config = function(_, opts)
      local ok, cmp = pcall(require, "cmp")

      if ok then
        cmp.event:on("menu_opened", function()
          vim.b.matchup_matchparen_enabled = false
        end)
        cmp.event:on("menu_closed", function()
          vim.b.matchup_matchparen_enabled = true
        end)
      end

      vim.g.matchup_matchparen_offscreen = { method = "popup", }

      require("match-up").setup(opts)
    end,
  },
  {
    "mg979/vim-visual-multi",
    branch = "master",
    event = "VeryLazy",
  },
  {
    "csexton/trailertrash.vim",
    event = { "BufReadPost", "BufNewFile", },
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
    -- config = true,
    config = function(_, opts)
      require("nvim-autopairs").setup(opts)

      local ok, cmp = pcall(require, "cmp")
      if ok then
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
      end
    end,
  },
  {
    "numToStr/Comment.nvim",
    event = { "BufReadPost", "BufNewFile", },
    dependencies = {
      "JoosepAlviste/nvim-ts-context-commentstring",
    },
    opts = function()
      local ts_context_comment_integration = require(
        "ts_context_commentstring.integrations.comment_nvim")

      return {
        padding = true,
        sticky = true,
        ignore = "^$",
        toggler = {
          line = "<leader>cc",
          block = "<leader>cb",
        },
        opleader = {
          line = "<leader>c",
          block = "<leader>b",
        },
        mappings = {
          basic = true,
          extra = true,
        },
        pre_hook = ts_context_comment_integration.create_pre_hook(),
      }
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    lazy = true,
    opts = {
      enable_autocmd = false,
    },
    init = function()
      vim.g.skip_ts_context_commentstring_module = true
    end,
  },
}
