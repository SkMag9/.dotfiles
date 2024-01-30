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
      vim.keymap.set("n", "<leader>q", vim.diagnostic.open_float, {})

      --- Only create keybinds when needed, aka on LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings(:h vim.lsp.*)
          local opts = { buffer = ev.buf }
          vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "gf", vim.lsp.buf.format, opts)
          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
          
        end,
      })

    end
  }
}
