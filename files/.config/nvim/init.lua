-- Lazy 
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- Lazy Plugins
local lazy_plugins = {
	-- LSP
	{
		"williamboman/mason.nvim",
		cmd = { "Mason", "MasonInstall", "MasonInstallAll", "MasonUpdate" },
		opts = { ensure_isntalled = {
				"css-lsp",
				"gofumpt",
				"goimports",
				"goimports-reviser",
				"golines",
				"gomodifytags",
				"gopls",
				"html-lsp",
				"lua-language-server",
				"prettier",
				"yamlfmt",
			}	
		},
		config = function(_, opts)
			vim.api.nvim_create_user_command("MasonInstallAll", function()
				if opts.ensure_installed and #opts.ensure_installed > 0 then
					vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
				end
			end, {})

			vim.g.mason_binaries_list = opts.ensure_installed
		end,
	}
}

-- Lazy Plugin Config 



-- Load Lazy Plugins
require("lazy").setup(lazy_plugins, opts)
require("mason").setup(mason_opts)
