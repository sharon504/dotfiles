return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "williamboman/mason.nvim", config = true },
		{ "williamboman/mason-lspconfig.nvim" },
	},
	config = function()
		local lspconfig = require("lspconfig")
		local mason_lspconfig = require("mason-lspconfig")

		-- Set up diagnostic symbols and config
		local function setup_diagnostic_signs()
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			vim.diagnostic.config({
				signs = true,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				virtual_text = true,
			})
		end

		-- Configure keymaps for LSP
		local function setup_lsp_keymaps(bufnr)
			local keymap = vim.keymap.set

			-- Navigation
			keymap("n", "gR", "<cmd>Telescope lsp_references<CR>", { buffer = bufnr, desc = "Show LSP references" })
			keymap("n", "gD", vim.lsp.buf.declaration, { buffer = bufnr, desc = "Go to declaration" })
			keymap("n", "gd", "<cmd>Telescope lsp_definitions<CR>", { buffer = bufnr, desc = "Show LSP definitions" })
			keymap(
				"n",
				"gi",
				"<cmd>Telescope lsp_implementations<CR>",
				{ buffer = bufnr, desc = "Show LSP implementations" }
			)
			keymap(
				"n",
				"gt",
				"<cmd>Telescope lsp_type_definitions<CR>",
				{ buffer = bufnr, desc = "Show LSP type definitions" }
			)

			-- Actions
			keymap(
				{ "n", "v" },
				"<leader>ca",
				function()
					require("actions-preview").code_actions()
				end,
				{ buffer = bufnr, desc = "See available code actions (with preview)" }
			)
			keymap("n", "<leader>rn", function()
				return ":IncRename " .. vim.fn.expand("<cword>")
			end, { buffer = bufnr, expr = true, desc = "Smart rename (with preview)" })

			-- Diagnostics
			keymap(
				"n",
				"<leader>D",
				"<cmd>Telescope diagnostics bufnr=0<CR>",
				{ buffer = bufnr, desc = "Show buffer diagnostics" }
			)
			keymap("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show line diagnostics" })
			keymap("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { buffer = bufnr, desc = "Go to previous diagnostic" })
			keymap("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { buffer = bufnr, desc = "Go to next diagnostic" })

			-- Utilities
			keymap("n", "<leader>rs", ":LspRestart<CR>", { buffer = bufnr, desc = "Restart LSP" })
		end

		-- Create LSP attach autocmd
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				setup_lsp_keymaps(ev.buf)
				
				-- Enable inlay hints if supported (Neovim 0.10+)
				local client = vim.lsp.get_client_by_id(ev.data.client_id)
				if client and client.server_capabilities.inlayHintProvider then
					vim.lsp.inlay_hint.enable(true, { bufnr = ev.buf })
				end
			end,
		})

		-- Setup diagnostic signs
		setup_diagnostic_signs()

		-- Get capabilities from blink.cmp
		local capabilities = require("blink.cmp").get_lsp_capabilities()

		-- LSP servers to install and configure
		-- All server-specific settings are defined here
		local servers = {
			-- Lua
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
							checkThirdParty = false,
						},
						telemetry = { enable = false },
					},
				},
			},

			-- Python
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

			-- JavaScript/TypeScript
			ts_ls = {},
			eslint = {},

			-- Go
			gopls = {
				settings = {
					gopls = {
						analyses = {
							unusedparams = true,
							staticcheck = true,
						},
						gofumpt = true,
					},
				},
			},

			-- C/C++
			clangd = {
				cmd = {
					"clangd",
					"--offset-encoding=utf-16",
					"--background-index",
					"--clang-tidy",
					"--header-insertion=iwyu",
				},
			},

			-- Rust: handled by rustaceanvim, but we keep it here for mason to install
			-- rust_analyzer = {},
		}

		-- Make sure Mason is set up before mason-lspconfig
		require("mason").setup()

		-- Configure mason-lspconfig to automatically install and manage LSPs
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers),
			automatic_installation = true,
			handlers = {
				-- Default handler for all servers
				function(server_name)
					-- Skip rust_analyzer as it's handled by rustaceanvim
					if server_name == "rust_analyzer" then
						return
					end

					local opts = {
						capabilities = capabilities,
					}

					local server_config = servers[server_name]
					if server_config then
						opts = vim.tbl_deep_extend("force", opts, server_config)
					end

					lspconfig[server_name].setup(opts)
				end,
			},
		})
	end,
}
