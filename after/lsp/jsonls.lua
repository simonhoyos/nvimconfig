local setup = {
  settings = {
    json = {
      -- https://www.schemastore.org/json
      schemas = {
        {
          fileMatch = { "package.json", },
          url = "https://json.schemastore.org/package.json",
        },
        {
          fileMatch = { "tsconfig*.json", },
          url = "https://json.schemastore.org/tsconfig.json",
        },
        {
          fileMatch = {
            ".eslintrc",
            ".eslintrc.json",
          },
          url = "https://json.schemastore.org/eslintrc.json",
        },
        {
          fileMatch = {
            ".prettierrc",
            ".prettierrc.json",
          },
          url = "https://json.schemastore.org/prettierrc.json",
        },
        {
          fileMatch = {
            "components.json",
            url = "https://ui.shadcn.com/schema.json",
          },
        },
      },
    },
  },
}

return setup
