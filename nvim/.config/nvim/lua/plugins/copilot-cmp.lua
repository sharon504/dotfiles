return {
	"zbirenbaum/copilot-cmp",
	dependencies = {
		"hrsh7th/nvim-cmp",
	},
	opts = {},
	config = function(_, opts)
		local copilot_cmp = require("copilot_cmp")
		copilot_cmp.setup(opts)

		-- Replace LazyVim.lsp.on_attach with direct autocmd for LSP attach
		vim.api.nvim_create_autocmd("LspAttach", {
			callback = function()
				copilot_cmp._on_insert_enter({})
			end,
			group = vim.api.nvim_create_augroup("CopilotCmpAttach", { clear = true }),
		})
	end,
	-- Replace specs with direct config for nvim-cmp
	init = function()
		-- This function runs before the plugin is loaded
		local has_cmp, cmp = pcall(require, "cmp")
		if has_cmp then
			-- Ensure the source is registered when cmp is available
			local config = cmp.get_config()
			table.insert(config.sources, 1, {
				name = "copilot",
				group_index = 1,
				priority = 100,
			})
			cmp.setup(config)
		end
	end,
}
