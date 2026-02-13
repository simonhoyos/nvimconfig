return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "master",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-live-grep-args.nvim",
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "make",
      },
      -- {
      --   "junegunn/fzf",
      --   build = function()
      --     vim.fn["fzf#install"]()
      --   end,
      -- },
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      local lga_actions = require("telescope-live-grep-args.actions")
      local builtins = require("telescope.builtin")

      telescope.setup({
        defaults = {
          file_ignore_patterns = {
            "node_modules",
            "target",
            "dist",
            "%.git/",
            "%.next/",
            "%.data/",
            "%.data%-crdb/",
            "%.vercel/",
            "%.venv/",
            "coverage",
            "conductor",
          },
          mappings = {
            n = {
              ["<C-h>"] = actions.which_key,
              ["<leader>d"] = actions.delete_buffer,
            },
            i = {
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-h>"] = actions.which_key,
            },
          },
          initial_mode = "normal",
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            width = 0.99,
            height = 0.99,
            mirror = false,
            prompt_position = "top",
            preview_width = 0.5,
          },
        },
        pickers = {
          find_files = {
            find_command = { "rg", "--hidden", "--unrestricted", "--files", "--sort", "path", },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
          },
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob ", }),
              },
            },
          },
        },
      })

      pcall(telescope.load_extension, "fzf")
      pcall(telescope.load_extension, "live_grep_args")

      local opts = { silent = true, noremap = true, }

      vim.keymap.set("n", "<C-p>", builtins.find_files,
        vim.tbl_extend("force", opts, { desc = "[NAV] Find files", }))
      vim.keymap.set("n", "<C-f>",
        telescope.extensions.live_grep_args.live_grep_args,
        vim.tbl_extend("force", opts, { desc = "[NAV] Live grep with args", }))
      vim.keymap.set("v", "<C-f>", builtins.grep_string,
        vim.tbl_extend("force", opts, { desc = "[NAV] Grep selected string", }))
      vim.keymap.set("n", "<leader>fgb", builtins.git_branches,
        vim.tbl_extend("force", opts, { desc = "[NAV] Git branches", }))
      vim.keymap.set("n", "<leader>fgc", builtins.git_commits,
        vim.tbl_extend("force", opts, { desc = "[NAV] Git commits", }))
      vim.keymap.set("n", "<leader>fgs", builtins.git_stash,
        vim.tbl_extend("force", opts, { desc = "[NAV] Git stash", }))
      vim.keymap.set("n", "<C-b>", builtins.buffers,
        vim.tbl_extend("force", opts, { desc = "[NAV] List buffers", }))
      vim.keymap.set("n", "<leader>fh", builtins.help_tags,
        vim.tbl_extend("force", opts, { desc = "[NAV] Help tags", }))
      vim.keymap.set("n", "/", builtins.current_buffer_fuzzy_find,
        vim.tbl_extend("force", opts, { desc = "[NAV] Fuzzy find in buffer", }))

      local command_opts = { bang = true, }

      vim.api.nvim_create_user_command("Builtins", builtins.builtin,
        vim.tbl_extend("force", command_opts,
          { desc = "[NAV] Search telescope builtins", }))
      vim.api.nvim_create_user_command("Commands", builtins.commands,
        vim.tbl_extend("force", command_opts, { desc = "[NAV] Search commands", }))
      vim.api.nvim_create_user_command("Mans", builtins.man_pages,
        vim.tbl_extend("force", command_opts,
          { desc = "[NAV] Search man pages", }))
      vim.api.nvim_create_user_command("Maps", builtins.keymaps,
        vim.tbl_extend("force", command_opts, { desc = "[NAV] Search keymaps", }))
      vim.api.nvim_create_user_command("Marks", builtins.marks,
        vim.tbl_extend("force", command_opts, { desc = "[NAV] Search marks", }))
      vim.api.nvim_create_user_command("Tags", builtins.tags,
        vim.tbl_extend("force", command_opts, { desc = "[NAV] Search tags", }))
    end,
  },
}
