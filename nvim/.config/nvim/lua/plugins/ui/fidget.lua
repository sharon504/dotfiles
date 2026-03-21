return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		progress = {
			poll_rate = 0.5,
			suppress_on_insert = true,
			ignore_done_already = false,
			ignore_empty_message = false,
			display = {
				render_limit = 16,
				done_ttl = 3,
				done_icon = "✔",
				progress_icon = { pattern = "dots", period = 1 },
				group_style = "Title",
				icon_style = "Question",
				priority = 30,
				skip_history = true,
			},
		},
		notification = {
			poll_rate = 10,
			filter = vim.log.levels.INFO,
			override_vim_notify = false, -- Let snacks handle vim.notify
			window = {
				normal_hl = "Comment",
				winblend = 0,
				border = "none",
				zindex = 45,
				max_width = 0,
				max_height = 0,
				x_padding = 1,
				y_padding = 0,
				align = "bottom",
				relative = "editor",
			},
		},
	},
	keys = {
		{
			"<leader>uf",
			function()
				-- Toggle fidget display
				vim.g.fidget_enabled = not vim.g.fidget_enabled
				if vim.g.fidget_enabled then
					vim.notify("Fidget LSP progress enabled", vim.log.levels.INFO)
				else
					vim.notify("Fidget LSP progress disabled", vim.log.levels.INFO)
					-- Clear any existing fidget displays
					require("fidget.progress").clear()
				end
			end,
			desc = "Toggle Fidget LSP Progress",
		},
	},
	init = function()
		vim.g.fidget_enabled = true
	end,
}
