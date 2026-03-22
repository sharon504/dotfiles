return {
	"mrcjkb/rustaceanvim",
	version = vim.fn.has("nvim-0.10.0") == 0 and "^4" or false,
	ft = { "rust" },
	opts = {
		server = {
			on_attach = function(_, bufnr)
				vim.keymap.set("n", "<leader>cR", function()
					vim.cmd.RustLsp("codeAction")
				end, { desc = "Code Action", buffer = bufnr })
				vim.keymap.set("n", "<leader>dr", function()
					vim.cmd.RustLsp("debuggables")
				end, { desc = "Rust Debuggables", buffer = bufnr })
			end,
			default_settings = {
				-- rust-analyzer language server configuration
				["rust-analyzer"] = {
					cargo = {
						allFeatures = true,
						loadOutDirsFromCheck = true,
						buildScripts = {
							enable = true,
						},
					},
					-- Add clippy lints for Rust
					checkOnSave = true,
					-- Enable diagnostics
					diagnostics = {
						enable = true,
					},
					procMacro = {
						enable = true,
						ignored = {
							["async-trait"] = { "async_trait" },
							["napi-derive"] = { "napi" },
							["async-recursion"] = { "async_recursion" },
						},
					},
					files = {
						excludeDirs = {
							".direnv",
							".git",
							".github",
							".gitlab",
							"bin",
							"node_modules",
							"target",
							"venv",
							".venv",
						},
					},
				},
			},
		},
	},
	config = function(_, opts)
		-- Check if mason.nvim is available
		local has_mason, _ = pcall(require, "mason-registry")
		if has_mason then
			local mason_path = vim.fn.stdpath("data") .. "/mason"
			local codelldb_path = mason_path .. "/packages/codelldb"

			-- Check if the directory exists
			if vim.fn.isdirectory(codelldb_path) == 1 then
				local codelldb = codelldb_path .. "/extension/adapter/codelldb"
				local library_path = codelldb_path .. "/extension/lldb/lib/liblldb.dylib"

				-- Check OS using io.popen (more compatible approach)
				local handle = io.popen("uname -s")
				local uname = ""
				if handle then
					uname = handle:read("*l")
					handle:close()
				end

				if uname == "Linux" then
					library_path = codelldb_path .. "/extension/lldb/lib/liblldb.so"
				elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
					codelldb = codelldb_path .. "/extension/adapter/codelldb.exe"
					library_path = codelldb_path .. "/extension/lldb/bin/liblldb.dll"
				end

				-- Debug prints to verify paths
				print("Codelldb executable path:", codelldb)
				print("Library path:", library_path)

				if vim.fn.filereadable(codelldb) == 1 then
					opts.dap = {
						adapter = require("rustaceanvim.config").get_codelldb_adapter(codelldb, library_path),
					}
					print("DAP adapter configuration set successfully")
				else
					print("Codelldb executable not found at:", codelldb)
				end
			else
				print("Codelldb package directory not found at:", codelldb_path)
			end
		end

		if vim.fn.executable("rust-analyzer") == 0 then
			vim.notify(
				"**rust-analyzer** not found in PATH, please install it.\nhttps://rust-analyzer.github.io/",
				vim.log.levels.ERROR,
				{ title = "rustaceanvim" }
			)
		end
	end,
}
