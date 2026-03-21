return {
	"christoomey/vim-tmux-navigator",
	cmd = {
		"TmuxNavigateLeft",
		"TmuxNavigateDown",
		"TmuxNavigateUp",
		"TmuxNavigateRight",
		"TmuxNavigatePrevious",
	},
	keys = {
		{ "<c-h>", "<cmd><C-U>TmuxNavigateLeft<cr>", desc = "Navigate to left window (tmux aware)" },
		{ "<c-j>", "<cmd><C-U>TmuxNavigateDown<cr>", desc = "Navigate to down window (tmux aware)" },
		{ "<c-k>", "<cmd><C-U>TmuxNavigateUp<cr>", desc = "Navigate to up window (tmux aware)" },
		{ "<c-l>", "<cmd><C-U>TmuxNavigateRight<cr>", desc = "Navigate to right window (tmux aware)" },
		{ "<c-\\>", "<cmd><C-U>TmuxNavigatePrevious<cr>", desc = "Navigate to previous window (tmux aware)" },
	},
}
