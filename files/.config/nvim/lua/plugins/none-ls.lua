return {
  {
    -- None-LS
    "nvimtools/none-ls.nvim",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          -- Global
          null_ls.builtins.diagnostics.trivy.with({
            extra_filetypes = { "dockerfile", "go", "gomod", "gowork", "gotmpl", "yaml", "yaml.ansible", "yaml.docker-compose" },
          }),

          -- Ansible
          null_ls.builtins.diagnostics.ansiblelint,

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

          -- Terraform
          null_ls.builtins.diagnostics.terraform_validate,
          null_ls.builtins.diagnostics.tfsec,
          null_ls.builtins.formatting.terraform_fmt,

          -- Web Dev
          null_ls.builtins.formatting.prettier.with({
            extra_args = {},
          }),
        },
      })
    end,
  },

  -- Mason <-> Null-LS/None-LS
  {
    "jay-babu/mason-null-ls.nvim",
    lazy = false,
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
          "shfmt",

          -- Lua
          "stylua",

          -- Python
          "black",
          "isort",

          -- Terraform
          "tflint",
          "tfsec",

          -- Web Dev
          "prettier",
        },
      })
    end,
  },
}
