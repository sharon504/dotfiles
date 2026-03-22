-- Filename: ~/github/dotfiles-latest/neovim/neobean/lua/plugins/copilot.lua
-- ~/github/dotfiles-latest/neovim/neobean/lua/plugins/copilot.lua

return {
	"zbirenbaum/copilot.lua",
	config = function()
		require("copilot").setup({
			suggestion = { enabled = false },
			panel = { enabled = false },
		})
	end,
}
