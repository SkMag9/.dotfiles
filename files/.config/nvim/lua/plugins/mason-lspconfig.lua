return {
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "clangd", 
          "lua_ls",
          "vimls",
          "bashls",
          "cssls",
          "dockerls",
          "gopls",
          "html",
          "tsserver",
          "jq",
          "pylsp",
          "sqlls",
          "terraformls",
          "tflint",
          "taplo",
          "vuels",
          "lemminx",
          "yamllsl",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      local lspconfig = require("lspconfig")
      lspconfig.lua_ls.setup({})
    end
  }
}
