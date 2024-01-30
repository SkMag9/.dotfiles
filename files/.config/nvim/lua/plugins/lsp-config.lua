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
          --"jqlsp",
          "pylsp",
          "sqlls",
          "terraformls",
          "tflint",
          "taplo",
          "vuels",
          "lemminx",
          --"yamlls",
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function ()
      -- Global Language Server Setup
      local lspconfig = require("lspconfig")

      -- Language Specific Setup
      --- Lua
      lspconfig.lua_ls.setup({})

      -- Keymaps
      --- On Startup
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, {})
--[[
      --- Only create keybinds when needed, aka on LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function()
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings(:h vim.lsp.*)
        end,
      })
--]]
    end
  }
}
