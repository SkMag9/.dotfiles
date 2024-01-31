return {
	{
		-- None-LS
		"nvimtools/none-ls.nvim",
		config = function()
			local null_ls = require("null-ls")
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			null_ls.setup({
				sources = {
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

					-- Web Dev
					null_ls.builtins.formatting.prettier.with({
						extra_args = {},
					}),
					null_ls.builtins.diagnostics.eslint_d,
				},
				--[[on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({
            group = augroup,
            buffer = bufnr,
          })
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
      --]]
			})
		end,
	},
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
					-- Lua
					"stylua",

					-- Python
					"black",
					"isort",

					-- Web Dev
					"jq",
					"prettier",
				},
			})
		end,
	},
}
