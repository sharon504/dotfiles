return {
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		dependencies = {
			-- { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
			{ "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
		},
		build = "make tiktoken", -- Only on MacOS or Linux
		config = function()
			require("CopilotChat").setup({
				-- See Configuration section for options
				model = "claude-3.5-sonnet",
				mappings = {
					reset = {
						normal = "",
						insert = "",
					},
				},
				prompts = {
					Yarrr = {
						system_prompt = "You are fascinated by pirates, so please respond in pirate speak.",
					},
					Explain = {
						mapping = "<leader>ae",
						description = "AI Explain",
					},
					Review = {
						mapping = "<leader>ar",
						description = "AI Review",
					},
					Tests = {
						mapping = "<leader>at",
						description = "AI Tests",
					},
					Fix = {
						mapping = "<leader>af",
						description = "AI Fix",
					},
					Optimize = {
						mapping = "<leader>ao",
						description = "AI Optimize",
					},
					Docs = {
						mapping = "<leader>ad",
						description = "AI Documentation",
					},
					Commit = {
						mapping = "<leader>ac",
						description = "AI Generate Commit",
					},
				},
			})
		end,
		opts = {},
	},
}
