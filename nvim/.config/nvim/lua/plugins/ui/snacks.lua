return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	opts = {
		-- Enable big file detection
		bigfile = { enabled = true },
		
		-- Terminal management (replaces toggleterm)
		terminal = {
			enabled = true,
			win = {
				position = "float",
				height = 0.8,
				width = 0.9,
			},
		},
		
		-- Notifications (works alongside noice)
		notifier = {
			enabled = true,
			timeout = 3000,
			width = { min = 40, max = 0.4 },
			height = { min = 1, max = 0.6 },
			margin = { top = 0, right = 1, bottom = 0 },
			padding = true,
			sort = { "level", "added" },
			icons = {
				error = " ",
				warn = " ",
				info = " ",
				debug = " ",
				trace = " ",
			},
		},
		
		-- Git integration enhancements
		git = {
			enabled = true,
		},
		
		-- Statuscolumn enhancements
		statuscolumn = {
			enabled = false, -- Keep your current statuscolumn setup
		},
		
		-- Quickfile (faster file loading)
		quickfile = { enabled = true },
		
		-- Dashboard (can replace alpha-nvim if preferred)
		dashboard = {
			enabled = false, -- Keep your alpha-nvim for now
		},
		
		-- Better input and select
		input = {
			enabled = true, -- Works with dressing.nvim
		},
		
		-- Scroll improvements
		scroll = {
			enabled = true,
			animate = {
				duration = { step = 15, total = 250 },
				easing = "linear",
			},
		},
		
		-- Word highlighting
		words = {
			enabled = true,
			debounce = 200,
		},
		
		-- Zen mode
		zen = {
			enabled = true,
			toggles = {
				dim = true,
				git_signs = false,
				mini_diff_signs = false,
				diagnostics = false,
				inlay_hints = false,
			},
			zoom = {
				width = 0.8,
				height = 0.9,
			},
		},
	},
	keys = {
		-- Terminal keybindings (replaces toggleterm)
		{
			"<c-t>",
			function()
				require("snacks").terminal()
			end,
			desc = "Toggle Terminal",
			mode = { "n", "t" },
		},
		{
			"<leader>gg",
			function()
				require("snacks").lazygit()
			end,
			desc = "Open Lazygit",
		},
		{
			"<leader>gB",
			function()
				require("snacks").git.blame_line()
			end,
			desc = "Show git blame for current line",
		},
		{
			"<leader>gf",
			function()
				require("snacks").lazygit.log_file()
			end,
			desc = "Lazygit Current File History",
		},
		{
			"<leader>gl",
			function()
				require("snacks").lazygit.log()
			end,
			desc = "Lazygit Log (cwd)",
		},
		-- Notifications
		{
			"<leader>un",
			function()
				require("snacks").notifier.hide()
			end,
			desc = "Dismiss All Notifications",
		},
		{
			"<leader>nh",
			function()
				require("snacks").notifier.show_history()
			end,
			desc = "Notification History",
		},
		-- Zen mode
		{
			"<leader>z",
			function()
				require("snacks").zen()
			end,
			desc = "Toggle Zen Mode",
		},
		{
			"<leader>Z",
			function()
				require("snacks").zen.zoom()
			end,
			desc = "Toggle Zoom",
		},
	},
	init = function()
		-- Set up autocommands for notifications
		vim.api.nvim_create_autocmd("User", {
			pattern = "VeryLazy",
			callback = function()
				-- Setup some globals for debugging (optional)
				_G.dd = function(...)
					require("snacks").debug.inspect(...)
				end
				_G.bt = function()
					require("snacks").debug.backtrace()
				end
				vim.print = _G.dd -- Override print to use snacks.debug.inspect
			end,
		})
	end,
}
