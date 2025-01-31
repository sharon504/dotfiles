return {
	"nvim-tree/nvim-tree.lua",
	version = "*",
	lazy = false,
	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},
	opts = {
		filesystem = {
			hijack_netrw_behavior = "false",
		},
	},
	config = function()
		require("nvim-tree").setup({
			view = {
				side = "right",
			},
		})
	end,
}
