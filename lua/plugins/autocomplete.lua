return {
  {
    "windwp/nvim-ts-autotag",
    opts = {},
  },
  {
    "mattn/emmet-vim",
    init = function()
      vim.g.user_emmet_mode = "a"
      vim.g.user_emmet_settings = {
        variables = {
          lang = "en",
        },
        html = {
          default_attributes = {
            option = {
              value = vim.v.null,
            },
            textarea = {
              id = vim.v.null,
              name = vim.v.null,
              cols = 10,
              rows = 10,
            },
          },
          snippets = {
            ["html:5"] = "<!DOCTYPE html>\n"
              .. '<html lang="${lang}">\n'
              .. "<head>\n"
              .. '\t<meta charset="${charset}">\n'
              .. '\t<meta name="viewport" content="width=device-width, initial-scale=1.0">\n'
              .. "\t<title></title>\n"
              .. "</head>\n"
              .. "<body>\n\t${child}|\n</body>\n"
              .. "</html>",
          },
        },
      }
    end,
  },
  -- TODO: requires additional configuration add to readme
  -- {
  --   'github/copilot.vim',
  --   config = function()
  --     local keymap = require('lib.keymap')

  --     vim.g.copilot_no_tab_map = true

  --     keymap.set('i', '<M-j>', 'copilot#Accept("\\<CR>")', {
  --       expr = true,
  --       replace_keycodes = false,
  --     })
  --     keymap.set('i', '<M-l>', '<Plug>(copilot-accept-word)')
  --     keymap.set('i', '<M-k>', '<Plug>(copilot-accept-line)')

  --     keymap.set('i', '<C-]>', '<Plug>(copilot-dismiss)')
  --     keymap.set('i', '<M-\\', '<Plug>(copilot-suggest)')
  --     keymap.set('i', '<M-]>', '<Plug>(copilot-next)')
  --     keymap.set('i', '<M-[>', '<Plug>(copilot-previous)')
  --   end,
  -- },
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/cmp-nvim-lua", },
      { "hrsh7th/cmp-path", },
      { "hrsh7th/cmp-buffer", },
      { "hrsh7th/cmp-cmdline", },
      { "hrsh7th/cmp-nvim-lsp", },
      {
        "L3MON4D3/LuaSnip",
        version = "v2.*",
        build = "make install_jsregexp",
      },
      { "saadparwaiz1/cmp_luasnip", },
      { "onsails/lspkind-nvim", },
    },
    opts = function()
      local cmp = require("cmp")
      local lspkind = require("lspkind")

      return {
        window = {
          completion = cmp.config.window.bordered({
            border = "rounded",
          }),
          documentation = cmp.config.window.bordered({
            border = "rounded",
          }),
        },
        sources = cmp.config.sources({
          { name = "luasnip", },
          { name = "nvim_lua", },
          { name = "nvim_lsp", },
          { name = "path", },
          { name = "buffer",   keyword_length = 5, },
        }),
        mapping = {
          ["<C-j>"] = cmp.mapping.select_next_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ["<C-k>"] = cmp.mapping.select_prev_item({
            behavior = cmp.SelectBehavior.Insert,
          }),
          ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c", }),
          ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c", }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-x>"] = cmp.mapping.abort(),
          ["<Enter>"] = cmp.mapping.confirm(),
          ["<Tab>"] = nil,
          ["<S-Tab>"] = nil,
        },
        experimental = {
          ghost_text = true,
        },
        formatting = {
          format = lspkind.cmp_format({
            mode = "symbol_text",
            maxwidth = 50,
            with_text = true,
            menu = {
              buffer = "[buf]",
              nvim_lsp = "[LSP]",
              nvim_lua = "[api]",
              path = "[path]",
              luasnip = "[snip]",
            },
          }),
        },
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
      }
    end,
    config = function(_, opts)
      local cmp = require("cmp")
      local keymap = require("lib.keymap")
      local cmp_lsp = require("cmp_nvim_lsp")

      vim.lsp.config("*", {
        capabilities = cmp_lsp.default_capabilities(),
      })

      cmp.setup(opts)

      vim.opt.completeopt = { "menu", "menuone", "noinsert", }

      cmp.setup.cmdline(":", {
        sources = cmp.config.sources({
          { name = "path", },
        }, {
          { name = "cmdline", },
        }),
      })

      require("snippets.lua")
      -- require('snippets.javascript')
      -- require('snippets.typescript')

      keymap.set("i", "<C-j>", "<Plug>luasnip-jump-next", { noremap = false, })
      keymap.set("i", "<C-k>", "<Plug>luasnip-jump-prev", { noremap = false, })
      keymap.set("i", "<C-e>", "<Plug>luasnip-next-choice", { noremap = false, })
    end,
  },
}
