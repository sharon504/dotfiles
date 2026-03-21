return {
	"lewis6991/hover.nvim",
	config = function()
		require("hover").config({
			--- List of modules names to load as providers.
			--- @type (string|Hover.Config.Provider)[]
			providers = {
				"hover.providers.diagnostic",
				"hover.providers.lsp",
				"hover.providers.dap",
				"hover.providers.man",
				"hover.providers.dictionary",
				-- Optional, disabled by default:
				-- 'hover.providers.gh',
				-- 'hover.providers.gh_user',
				-- 'hover.providers.jira',
				-- 'hover.providers.fold_preview',
				-- 'hover.providers.highlight',
			},
			preview_opts = {
				border = "single",
			},
			-- Whether the contents of a currently open hover window should be moved
			-- to a :h preview-window when pressing the hover keymap.
			preview_window = false,
			title = true,
			mouse_providers = {
				"hover.providers.lsp",
			},
			mouse_delay = 1000,
		})

		-- Setup keymaps
		vim.keymap.set("n", "K", function()
			require("hover").open()
		end, { desc = "Show hover documentation" })

		vim.keymap.set("n", "gK", function()
			require("hover").enter()
		end, { desc = "Enter hover window" })

		vim.keymap.set("n", "<C-p>", function()
			require("hover").switch("previous")
		end, { desc = "Switch to previous hover source" })

		vim.keymap.set("n", "<C-n>", function()
			require("hover").switch("next")
		end, { desc = "Switch to next hover source" })

		-- Mouse support
		vim.keymap.set("n", "<MouseMove>", function()
			require("hover").mouse()
		end, { desc = "Show hover on mouse movement" })

		vim.o.mousemoveevent = true
	end,
}
