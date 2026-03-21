return {
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	opts = {
		headerMaxWidth = 80,
		-- Minimum number of chars in search string required to run search
		minSearchChars = 2,
		-- Search on the fly as you type
		searchOnTypeDelay = 500,
		-- Wrap text in results
		wrap = true,
		-- Debounce milliseconds for search while typing
		debounceMs = 500,
	},
	keys = {
		{
			"<leader>sr",
			function()
				require("grug-far").open()
			end,
			mode = { "n", "v" },
			desc = "Search and Replace (grug-far)",
		},
		{
			"<leader>sf",
			function()
				require("grug-far").open({ prefills = { paths = vim.fn.expand("%") } })
			end,
			desc = "Search and Replace in current file",
		},
		{
			"<leader>sw",
			function()
				require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } })
			end,
			desc = "Search and Replace word under cursor",
		},
	},
}
