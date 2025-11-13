return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "antosha417/nvim-lsp-file-operations", config = true },
		{ "williamboman/mason.nvim", config = true },
		{ "williamboman/mason-lspconfig.nvim" },
	},
	config = function()
		-- import lspconfig plugin
		local lspconfig = require("lspconfig")

		-- import mason_lspconfig plugin
		local mason_lspconfig = require("mason-lspconfig")

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
		local capabilities = require("cmp_nvim_lsp").default_capabilities()

		-- Server-specific configurations to be passed to lspconfig
		local servers = {
			-- These will be passed to lspconfig's setup function
			lua_ls = {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
						completion = { callSnippet = "Replace" },
					},
				},
			},
			biome = {
				root_dir = require("lspconfig.util").root_pattern("biome.json", ".git"),
			},
			-- Add other servers here if you want to override their default settings
			-- Otherwise, mason will install them and they will be set up with defaults
			eslint = {},
			ts_ls = {},
			rust_analyzer = {},
			pyright = {},
			clangd = {},
			graphql = {},
			emmet_ls = {},
		}

		-- Make sure Mason is set up before mason-lspconfig
		require("mason").setup()

		-- Configure mason-lspconfig to automatically install and manage LSPs
		mason_lspconfig.setup({
			ensure_installed = vim.tbl_keys(servers), -- ensures servers in the table above are installed
			handlers = {
				-- The first entry (without a key) will be the default handler.
				-- This will be called for each server that is installed.
				function(server_name)
					local opts = {
						capabilities = capabilities,
					}
					-- Get the server-specific settings from our `servers` table
					local server_config = servers[server_name]
					if server_config then
						-- Extend the default opts with the server-specific settings
						opts = vim.tbl_deep_extend("force", opts, server_config)
					end
					-- Finally, set up the server with lspconfig
					lspconfig[server_name].setup(opts)
				end,
			},
		})
	end,
}
