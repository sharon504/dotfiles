return {
	"williamboman/mason.nvim",
	dependencies = {
		"williamboman/mason-lspconfig.nvim",
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"neovim/nvim-lspconfig",
	},
	config = function()
		-- import mason
		local mason = require("mason")
		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
				keymaps = {
					-- Keymap to expand a package
					toggle_package_expand = "<CR>",
					-- Install the selected package
					install_package = "i",
					-- Update the selected package
					update_package = "u",
					-- Check for new version of the selected package
					check_package_version = "c",
					-- Update all installed packages
					update_all_packages = "U",
					-- Uninstall a package
					uninstall_package = "X",
					-- Cancel a package installation
					cancel_installation = "<C-c>",
				},
			},
			max_concurrent_installers = 10,
		})

		-- import mason-lspconfig
		local mason_lspconfig = require("mason-lspconfig")

		-- import nvim-lspconfig
		local lspconfig = require("lspconfig")

		local mason_tool_installer = require("mason-tool-installer")

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local has_cmp, cmp = pcall(require, "cmp_nvim_lsp")
		if has_cmp then
			capabilities = cmp.default_capabilities()
		end

		-- Language server configuration
		local servers = {
			-- Web development
			-- "eslint",

			-- Lua development
			-- "lua_ls",

			-- Python development
			-- "pyright",

			-- C/C++ development
			-- "clangd",
		}

		-- Formatters and linters configuration
		local tools = {
			-- General
			"prettier", -- formatter for web languages

			-- Lua
			"stylua", -- lua formatter

			-- Python
			"isort", -- python formatter
			"black", -- python formatter
			"pylint", -- python linter

			-- JavaScript/TypeScript
			"eslint_d", -- JavaScript/TypeScript linter

			-- C/C++
			"clang-format", -- C/C++ formatter
			"cpplint", -- C/C++ linter
		}

		-- Server specific configuration
		local server_configs = {
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim", "require" },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
			clangd = {
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
				},
			},
			pyright = {
				settings = {
					python = {
						analysis = {
							typeCheckingMode = "basic",
							autoSearchPaths = true,
							useLibraryCodeForTypes = true,
						},
					},
				},
			},
		}

		mason_lspconfig.setup({
			-- list of servers for mason to install
			ensure_installed = servers,
			-- auto-install configured servers (with lspconfig)
			automatic_installation = true,
			automatic_enable = true,
		})

		-- Get all installed servers
		local installed_servers = mason_lspconfig.get_installed_servers()

		-- Set up each installed server
		for _, server_name in ipairs(installed_servers) do
			local opts = {
				capabilities = capabilities,
				on_attach = function(client)
					-- You can add custom on_attach logic here
					-- For example, disable formatting for certain clients
					if client.name == "tsserver" then
						client.server_capabilities.documentFormattingProvider = false
					end
				end,
			}

			-- Add server-specific options if they exist
			if server_configs[server_name] then
				opts = vim.tbl_deep_extend("force", opts, server_configs[server_name])
			end

			lspconfig[server_name].setup(opts)
		end

		mason_tool_installer.setup({
			ensure_installed = tools,
			auto_update = false,
			run_on_start = true,
			start_delay = 3000, -- 3 seconds delay
		})

		-- Register a handler that will set up formatters for specific filetypes
		-- This can be expanded with formatting and linting configuration
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "c", "cpp" },
			callback = function()
				-- Set up formatprg for C/C++ files to use clang-format
				vim.bo.formatprg = "clang-format --assume-filename=% --style=file"

				-- Set up formatting with leader command
				vim.keymap.set("n", "<leader>cf", function()
					vim.cmd("normal gggqG")
				end, { buffer = true, desc = "Format C/C++ file with clang-format" })

				-- Set up linting with cpplint
				vim.keymap.set("n", "<leader>cl", function()
					vim.cmd("! cpplint %")
				end, { buffer = true, desc = "Lint C/C++ file with cpplint" })

				-- Set up static analysis with cppcheck
				vim.keymap.set("n", "<leader>cs", function()
					vim.cmd("! cppcheck --enable=all --suppressions-list=.cppcheck_suppressions %")
				end, { buffer = true, desc = "Static analysis with cppcheck" })

				-- Option: format on save (uncomment to enable)
				-- vim.api.nvim_create_autocmd("BufWritePre", {
				-- 	buffer = 0,
				-- 	callback = function()
				-- 		vim.cmd("normal gggqG")
				-- 	end,
				-- })
			end,
		})

		-- Expose configuration for other modules to use
		_G.mason_config = {
			servers = servers,
			tools = tools,
			server_configs = server_configs,
		}
	end,
}
