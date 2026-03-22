return {
	"echasnovski/mini.nvim",
	version = false,
	config = function()
		require("mini.ai").setup()
		require("mini.bracketed").setup()
		require("mini.comment").setup()
		require("mini.git").setup()
		require("mini.surround").setup()
		require("mini.pairs").setup()
		require("mini.notify").setup()
		require("mini.animate").setup()
	end,
}
