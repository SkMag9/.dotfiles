return {
  -- Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason <-> lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          -- Only LSPs in the list:
          -- https://mason-registry.dev/registry
          "ansiblels",
          "bashls",
          "cssls",
          -- "docker-compose-language-service",
          "dockerls",
          "gopls",
          "helm_ls",
          "html",
          -- "htmx-lsp",
          "lua_ls",
          "pyright",
          "sqlls",
          "terraformls",
          -- "tsserver", -- Typescript
          -- "vue-language-server", -- Vue
          "yamlls",
        },
      })
    end,
  },

  -- lspconfig
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Global Language Server Setup
      local capabilities = require("cmp_nvim_lsp").default_capabilities() -- completion stuff
      local lspconfig = require("lspconfig")

      -- Language Specific Setup
      --- Bash
      lspconfig.bashls.setup({ capabilities = capabilities })

      --- Go
      lspconfig.gopls.setup({ capabilities = capabilities })

      --- Lua
      lspconfig.lua_ls.setup({ capabilities = capabilities })

      --- Python
      lspconfig.pyright.setup({ capabilities = capabilities })

      -- Terraform
      lspconfig.terraformls.setup({ capabilities = capabilities })

      --- TypeScript
      lspconfig.tsserver.setup({ capabilities = capabilities })

      -- Keymaps
      --- On Startup
      vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist,
        { desc = "show diagnostics list", })

      --- Only create keybinds when needed, aka on LspAttach
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          -- Enable completion triggered by <c-x><c-o>
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"

          -- Buffer local mappings(:h vim.lsp.*)
          vim.keymap.set("n", "K", vim.lsp.buf.hover,
            { desc = "hover", buffer = ev.buf })

          vim.keymap.set("n", "gD", vim.lsp.buf.declaration,
            { desc = "go to declration", buffer = ev.buf })

          vim.keymap.set("n", "gd", vim.lsp.buf.definition,
            { desc = "go to definition", buffer = ev.buf })

          vim.keymap.set("n", "gi", vim.lsp.buf.implementation,
            { desc = "go to implementation", buffer = ev.buf })

          vim.keymap.set("n", "gr", vim.lsp.buf.references,
            { desc = "show list of references", buffer = ev.buf })

          vim.keymap.set("n", "gf", vim.lsp.buf.format,
            { desc = "format file", buffer = ev.buf })

          vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help,
            { desc = "signature help", buffer = ev.buf })

          vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename,
            { desc = "rename", buffer = ev.buf })

          vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action,
            { desc = "code actions", buffer = ev.buf })
        end,
      })
    end
  }
}
