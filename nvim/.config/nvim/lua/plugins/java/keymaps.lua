-- Java and Spring Boot Keymaps
-- Only loaded when Java files are opened
-- Prefix: <leader>J for Java commands

return {
	"nvim-java/nvim-java",
	keys = {
		-- Java Build Commands (<leader>Jb prefix)
		{ "<leader>Jbb", "<cmd>JavaBuildBuildWorkspace<cr>", desc = "Java: Build workspace" },
		{ "<leader>Jbc", "<cmd>JavaBuildCleanWorkspace<cr>", desc = "Java: Clean workspace" },

		-- Java Runner Commands (<leader>Jr prefix)
		{
			"<leader>Jrr",
			function()
				require("java").runner.built_in.run_app()
			end,
			desc = "Java: Run main class",
		},
		{
			"<leader>Jrs",
			function()
				require("java").runner.built_in.stop_app()
			end,
			desc = "Java: Stop running app",
		},
		{
			"<leader>Jrl",
			function()
				require("java").runner.built_in.toggle_logs()
			end,
			desc = "Java: Toggle runner logs",
		},

		-- Java Test Commands (<leader>Jt prefix)
		{
			"<leader>Jtc",
			function()
				require("java").test.run_current_class()
			end,
			desc = "Java: Run current test class",
		},
		{
			"<leader>Jtm",
			function()
				require("java").test.run_current_method()
			end,
			desc = "Java: Run current test method",
		},
		{
			"<leader>Jta",
			function()
				require("java").test.run_all_tests()
			end,
			desc = "Java: Run all tests",
		},
		{
			"<leader>Jtd",
			function()
				require("java").test.debug_current_method()
			end,
			desc = "Java: Debug current test method",
		},
		{
			"<leader>JtD",
			function()
				require("java").test.debug_current_class()
			end,
			desc = "Java: Debug current test class",
		},
		{
			"<leader>Jtr",
			function()
				require("java").test.view_last_report()
			end,
			desc = "Java: View last test report",
		},

		-- Spring Boot Commands (<leader>Js prefix)
		{
			"<leader>Jsb",
			function()
				-- Use Telescope to find Spring Beans via LSP workspace symbols
				require("telescope.builtin").lsp_workspace_symbols({
					query = "@",
					prompt_title = "Spring Beans",
				})
			end,
			desc = "Spring: Find Spring Beans",
		},
		{
			"<leader>Jse",
			function()
				-- Find Web Endpoints (REST controllers, mappings)
				require("telescope.builtin").lsp_workspace_symbols({
					query = "RequestMapping",
					prompt_title = "Web Endpoints",
				})
			end,
			desc = "Spring: Find Web Endpoints",
		},
		{
			"<leader>Jsp",
			function()
				-- Navigate to application properties/yml
				require("telescope.builtin").find_files({
					search_file = "application.*",
					prompt_title = "Spring Properties",
				})
			end,
			desc = "Spring: Find application properties",
		},

		-- Java Refactoring Commands (<leader>Je prefix)
		{
			"<leader>Jev",
			function()
				require("java").refactor.extract_variable()
			end,
			mode = { "n", "v" },
			desc = "Java: Extract variable",
		},
		{
			"<leader>Jec",
			function()
				require("java").refactor.extract_constant()
			end,
			mode = { "n", "v" },
			desc = "Java: Extract constant",
		},
		{
			"<leader>Jem",
			function()
				require("java").refactor.extract_method()
			end,
			mode = { "n", "v" },
			desc = "Java: Extract method",
		},
		{
			"<leader>Jef",
			function()
				require("java").refactor.extract_field()
			end,
			mode = { "n", "v" },
			desc = "Java: Extract field",
		},
		{
			"<leader>JeV",
			function()
				require("java").refactor.extract_variable_all_occurrence()
			end,
			mode = { "n", "v" },
			desc = "Java: Extract variable (all occurrences)",
		},

		-- Java Settings Commands (<leader>Jc prefix)
		{
			"<leader>Jcr",
			function()
				require("java").settings.change_runtime()
			end,
			desc = "Java: Change JDK runtime",
		},
		{
			"<leader>Jcp",
			function()
				require("java").profile.ui()
			end,
			desc = "Java: Open profiles UI",
		},

		-- Additional Java Commands (<leader>J prefix)
		{ "<leader>JdC", "<cmd>JdtUpdateDebugConfig<cr>", desc = "Java: Update debug config" },
		{ "<leader>JdH", "<cmd>JdtUpdateHotcode<cr>", desc = "Java: Update hotcode" },
		{ "<leader>Ju", "<cmd>JdtUpdateConfig<cr>", desc = "Java: Update project config" },
		{ "<leader>JB", "<cmd>JdtBytecode<cr>", desc = "Java: Show bytecode" },
		{ "<leader>JJ", "<cmd>JdtJshell<cr>", desc = "Java: Open JShell" },
		{ "<leader>JR", "<cmd>JdtRestart<cr>", desc = "Java: Restart JDTLS" },
	},
}
