return {
	"stevearc/conform.nvim",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local conform = require("conform")

		conform.setup({
			formatters_by_ft = {
				-- Lua
				lua = { "stylua" },

				-- Python
				python = { "isort", "black" },

				-- JavaScript/TypeScript
				javascript = { "prettier" },
				typescript = { "prettier" },
				javascriptreact = { "prettier" },
				typescriptreact = { "prettier" },
				json = { "prettier" },
				yaml = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				markdown = { "prettier" },

				-- Go
				go = { "goimports", "gofumpt" },

				-- C/C++
				c = { "clang-format" },
				cpp = { "clang-format" },

				-- Rust
				rust = { "rustfmt" },

				-- Java
				java = { "google-java-format" },
			},

			-- Format on save globally
			format_on_save = {
				timeout_ms = 1000,
				lsp_fallback = true,
			},
		})

		-- Manual format keybinding
		vim.keymap.set({ "n", "v" }, "<leader>mp", function()
			conform.format({
				lsp_fallback = true,
				async = false,
				timeout_ms = 1000,
			})
		end, { desc = "Format file or range (in visual mode)" })
	end,
}
