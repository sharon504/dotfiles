return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.ai").setup({
			n_lines = 500, -- Max number of lines to search (increase if needed for large functions)
			custom_textobjects = {
				-- Tree-sitter-based function outer/inner (uses u/function.outer and u/function.inner captures)
				f = require("mini.ai").gen_spec.treesitter({
					a = "@function.outer",
					i = "@function.inner",
				}),
				-- Add more custom ones if needed, e.g., for classes or blocks
				-- c = mini.ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }),
			},
		})
		require("mini.bracketed").setup()
		require("mini.comment").setup()
		require("mini.git").setup()
		require("mini.surround").setup()
		require("mini.pairs").setup()
		require("mini.animate").setup()
	end,
}
