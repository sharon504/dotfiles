return {
	"AlphaTechnolog/pywal.nvim",
	as = "pywal",
	config = function()
		require("pywal").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			transparent = true,
			italic_comments = true,
			hide_fillchars = true,
			borderless_telescope = true,
			terminal_colors = true,
		})
		vim.cmd("colorscheme pywal") -- set the colorscheme
	end,
}
