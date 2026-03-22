return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("noice").setup({
			lsp = {
				progress = {
					enabled = false,
				},
				messages = {
					enabled = false,
				},
			},
		})
	end,
}
