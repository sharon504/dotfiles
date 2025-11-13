return {
	"mfussenegger/nvim-dap",
	recommended = true,
	desc = "Debugging support. Requires language specific adapters to be configured. (see lang extras)",

	dependencies = {
		"rcarriga/nvim-dap-ui",
		-- virtual text for the debugger
		{
			"theHamsta/nvim-dap-virtual-text",
			opts = {},
		},
	},

  -- stylua: ignore
  keys = {
    { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
    { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
    { "<leader>dc", function() require("dap").continue() end, desc = "Run/Continue" },
    { "<leader>da", function() require("dap").continue({ before = get_args }) end, desc = "Run with Args" },
    { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
    { "<leader>dg", function() require("dap").goto_() end, desc = "Go to Line (No Execute)" },
    { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
    { "<leader>dj", function() require("dap").down() end, desc = "Down" },
    { "<leader>dk", function() require("dap").up() end, desc = "Up" },
    { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
    { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
    { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
    { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
    { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
    { "<leader>ds", function() require("dap").session() end, desc = "Session" },
    { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
    { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
  },

	config = function()
		-- load mason-nvim-dap here, after all adapters have been setup
		local has_mason_dap, mason_dap = pcall(require, "mason-nvim-dap")
		if has_mason_dap then
			mason_dap.setup({})
		end
		local dap_loaded, dap = pcall(require, "nvim-dap")
		if dap_loaded then
			-- Define sign icons for DAP
			vim.fn.sign_define(
				"DapBreakpoint",
				{ text = "🛑", texthl = "DapBreakpoint", linehl = "DapBreakpointLine", numhl = "DapBreakpointLine" }
			)
			vim.fn.sign_define("DapBreakpointCondition", {
				text = "🔍",
				texthl = "DapBreakpointCondition",
				linehl = "DapBreakpointLine",
				numhl = "DapBreakpointLine",
			})
			vim.fn.sign_define("DapBreakpointRejected", {
				text = "⚠️",
				texthl = "DapBreakpointRejected",
				linehl = "DapBreakpointLine",
				numhl = "DapBreakpointLine",
			})
			vim.fn.sign_define(
				"DapLogPoint",
				{ text = "📝", texthl = "DapLogPoint", linehl = "DapLogPointLine", numhl = "DapLogPointLine" }
			)
			vim.fn.sign_define(
				"DapStopped",
				{ text = "→", texthl = "DapStopped", linehl = "DapStoppedLine", numhl = "DapStoppedLine" }
			)

			-- You can also customize the highlight groups
			vim.cmd([[
    highlight DapBreakpoint guifg=#993939
    highlight DapBreakpointLine guibg=#331111
    highlight DapBreakpointCondition guifg=#993939
    highlight DapLogPoint guifg=#61afef
    highlight DapLogPointLine guibg=#102040
    highlight DapStopped guifg=#98c379 guibg=#31392b
    highlight DapStoppedLine guibg=#31392b
  ]])
		end

		vim.api.nvim_set_hl(0, "DapStoppedLine", { default = true, link = "Visual" })

		-- setup dap config by VsCode launch.json file
		local vscode = require("dap.ext.vscode")
		local json = require("plenary.json")
		vscode.json_decode = function(str)
			return vim.json.decode(json.json_strip_comments(str))
		end
		-- Setup for codelldb with nvim-dap
		if dap_loaded then
			-- Get Mason install path
			local mason_path = vim.fn.stdpath("data") .. "/mason"
			local codelldb_path = mason_path .. "/packages/codelldb"

			if vim.fn.isdirectory(codelldb_path) == 1 then
				local codelldb = codelldb_path .. "/extension/adapter/codelldb"

				-- Check OS for correct library path
				local handle = io.popen("uname -s")
				local uname = ""
				if handle then
					uname = handle:read("*l")
					handle:close()
				end

				if uname == "Linux" then
				elseif vim.fn.has("win32") == 1 or vim.fn.has("win64") == 1 then
					codelldb = codelldb_path .. "/extension/adapter/codelldb.exe"
				end

				-- Configure Rust adapter
				dap.adapters.codelldb = {
					type = "server",
					port = "${port}",
					executable = {
						command = codelldb,
						args = { "--port", "${port}" },
					},
				}

				-- Configure Rust launch configurations
				dap.configurations.rust = {
					{
						name = "Launch file",
						type = "codelldb",
						request = "launch",
						program = function()
							return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
						end,
						cwd = "${workspaceFolder}",
						stopOnEntry = false,
					},
				}
			end
		end
	end,
}
