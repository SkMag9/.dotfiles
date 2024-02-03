return {
  {
    -- None-LS
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Bash
          null_ls.builtins.diagnostics.shellcheck,
          null_ls.builtins.code_actions.shellcheck,
          null_ls.builtins.formatting.shfmt.with({
            extra_args = { "-i", "2", "-bn", "-ci" },
          }),

          -- Go
          null_ls.builtins.formatting.gofumpt,
          null_ls.builtins.formatting.goimports_reviser,
          null_ls.builtins.formatting.golines.with({
            extra_args = { "-m", "80", "-t", "2", "--shorten-comments" },
          }),

          -- Lua
          null_ls.builtins.formatting.stylua,

          -- Python
          null_ls.builtins.formatting.black,
          null_ls.builtins.formatting.isort,

          -- TOML
          null_ls.builtins.formatting.taplo,

          -- Web Dev
          null_ls.builtins.formatting.prettier.with({
            extra_args = {},
          }),
          null_ls.builtins.diagnostics.eslint_d,
        },
      })
    end,
  },

  -- Mason <-> Null-LS/None-LS
  {
    "jay-babu/mason-null-ls.nvim",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "williamboman/mason.nvim",
      "nvimtools/none-ls.nvim",
    },
    config = function()
      require("mason-null-ls").setup({
        ensure_installed = {
          -- Global
          "trivy",

          -- Bash
          "shellcheck",

          -- Lua
          "stylua",

          -- Python
          "black",
          "isort",

          -- TOML
          "taplo",

          -- Web Dev
          "jq",
          "prettier",
        },
      })
    end,
  },
}
