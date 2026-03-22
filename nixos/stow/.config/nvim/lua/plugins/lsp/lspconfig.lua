return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
    { "williamboman/mason.nvim", config = true },
		{ "williamboman/mason-lspconfig.nvim" },
		-- { "folke/neodev.nvim", opts = {} },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

		-- import cmp-nvim-lsp plugin

		-- Set up diagnostic symbols
		-- Set up diagnostic symbols and config
		local function setup_diagnostic_signs()
			local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }
			for type, icon in pairs(signs) do
				local hl = "DiagnosticSign" .. type
				vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
			end

			-- Configure diagnostics display
			vim.diagnostic.config({
				signs = true,
				update_in_insert = false,
				underline = true,
				severity_sort = true,
				virtual_text = true, -- Disable virtual text as we're showing signs in gutter
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
				vim.lsp.buf.code_action,
				{ buffer = bufnr, desc = "See available code actions" }
			)
			keymap("n", "<leader>rn", vim.lsp.buf.rename, { buffer = bufnr, desc = "Smart rename" })

			-- Diagnostics
			keymap(
				"n",
				"<leader>D",
				"<cmd>Telescope diagnostics bufnr=0<CR>",
				{ buffer = bufnr, desc = "Show buffer diagnostics" }
			)
			keymap("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "Show line diagnostics" })
			keymap("n", "dn", vim.diagnostic.jump, { buffer = bufnr, desc = "Go to previous diagnostic" })

			-- Documentation and utilities
			keymap(
				"n",
				"K",
				vim.lsp.buf.hover,
				{ buffer = bufnr, desc = "Show documentation for what is under cursor" }
			)
			keymap("n", "<leader>rs", ":LspRestart<CR>", { buffer = bufnr, desc = "Restart LSP" })
		end

		-- Create LSP attach autocmd
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("UserLspConfig", {}),
			callback = function(ev)
				setup_lsp_keymaps(ev.buf)
			end,
		})

		-- Setup diagnostic signs
		setup_diagnostic_signs()

		-- Get capabilities from cmp

		-- Server-specific configurations
		local server_configs = {
			graphql = {
				filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
			},
			emmet_ls = {
				filetypes = {
					"html",
					"typescriptreact",
					"javascriptreact",
					"css",
					"sass",
					"scss",
					"less",
					"svelte",
				},
			},
			eslint = {
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
				settings = {
					eslint = {
						validate = { "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" },
						run = "onType",
					},
				},
			},
			clangd = {
				filetypes = { "c", "cpp", "objc", "objcpp", "cuda", "proto" },
			},
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = {
							globals = { "vim" },
						},
						completion = {
							callSnippet = "Replace",
						},
					},
				},
			},
		}

		-- Set up handler for mason-lspconfig
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Make sure mason-lspconfig is properly set up first
		mason_lspconfig.setup()

		-- Get all installed servers
		local installed_servers = mason_lspconfig.get_installed_servers()

		-- Set up each installed server
		for _, server_name in ipairs(installed_servers) do
			local config = {
				capabilities = capabilities,
			}

			-- Merge with server-specific config if available
			if server_configs[server_name] then
				for k, v in pairs(server_configs[server_name]) do
					config[k] = v
				end
			end

			lspconfig[server_name].setup(config)
		end
	end,
}
