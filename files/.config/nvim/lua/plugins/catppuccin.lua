return {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	init = function()
		require("catppuccin").setup({
			flavour = "mocha",
			no_italic = true,
			styles = {
        comments = {},
        conditionals = {},
      },
      integrations = {
				cmp = true,
				gitsigns = true,
				nvimtree = true,
				treesitter = true,
			},
		})
	end,
	config = function()
		vim.cmd.colorscheme("catppuccin-mocha")
	end,
}
