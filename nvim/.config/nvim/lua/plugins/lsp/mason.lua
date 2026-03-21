return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
	},
	config = function()
		local mason = require("mason")
		local mason_tool_installer = require("mason-tool-installer")

		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				keymaps = {
					toggle_package_expand = "<CR>",
					install_package = "i",
					update_package = "u",
					check_package_version = "c",
					update_all_packages = "U",
					uninstall_package = "X",
					cancel_installation = "<C-c>",
				},
			},
			max_concurrent_installers = 10,
		})

		-- Formatters and linters to be installed
		-- LSP servers are managed by mason-lspconfig in lspconfig.lua
		local tools = {
			-- Lua
			"stylua",

			-- Python
			"black",
			"isort",
			"pylint",
			"ruff",

			-- JavaScript/TypeScript
			"prettier",
			"eslint_d",

			-- Go
			"gofumpt",
			"goimports",
			"golangci-lint",

			-- C/C++
			"clang-format",
			"cpplint",

			-- Rust (rustfmt typically comes with rustup, but we can install via mason)
			"rustfmt",

			-- Java
			"jdtls", -- Java Language Server
			"java-debug-adapter", -- Java debugger
			"java-test", -- JUnit test runner
			"google-java-format", -- Java formatter
			"checkstyle", -- Java linter
		}

		mason_tool_installer.setup({
			ensure_installed = tools,
			auto_update = true, -- Auto-update installed tools
			run_on_start = true,
			start_delay = 3000,
		})
	end,
}
