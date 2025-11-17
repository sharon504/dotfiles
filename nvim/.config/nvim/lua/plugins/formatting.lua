return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				javascript = { "biome", "prettier" },
				typescript = { "biome", "prettier" },
				javascriptreact = { "biome" },
				typescriptreact = { "biome" },
				lua = { "stylua" },
				python = { "black", "isort" },
				java = { "google-java-format", "ast-grep", "clang-format" },
			},
			formatters = {
				biome = {
					-- Let conform.nvim use the default biome command resolution
					-- This will use Mason's biome or system biome automatically
					cwd = require("conform.util").root_file({ "biome.json", ".git" }),
					require_cwd = true,
				},
			},
			-- Optional: Format on save
			format_on_save = {
				-- timeout_ms = 500,
				-- lsp_fallback = true,
			},
		})

		-- Format keybinding
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = true,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
