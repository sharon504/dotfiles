return {
	"NeogitOrg/neogit",
	dependencies = {
		"nvim-lua/plenary.nvim", -- required
		"sindrets/diffview.nvim", -- optional - Diff integration

		-- Only one of these is needed.
		-- "nvim-telescope/telescope.nvim", -- optional
		-- "ibhagwan/fzf-lua",              -- optional
		-- "echasnovski/mini.pick",         -- optional
		"folke/snacks.nvim", -- optional
	},
	config = function()
		require("neogit").setup({
			kind = "floating",
			signs = {
				-- { CLOSED, OPENED }
				section = { "", "" },
				item = { "", "" },
				hunk = { "", "" },
			},
			integrations = { diffview = true }, -- adds integration with diffview.nvim
		})
	end,
}
