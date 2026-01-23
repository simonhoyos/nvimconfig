local setup = {
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { "vim" },
      },
      format = {
        enable = true,
        defaultConfig = {
          -- https://github.com/CppCXY/EmmyLuaCodeStyle/blob/master/docs/format_config_EN.md
          indent_style = "space",
          indent_size = "2",
          quote_style = "double",
          call_arg_parentheses = "always",
          continuation_indent = "2",
          max_line_length = "80",
          trailing_table_separator = "always",
          insert_final_newline = "true"
        }
      }
    },
  },
}

return setup
