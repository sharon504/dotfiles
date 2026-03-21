return {
	"nvim-java/nvim-java",
	ft = { "java" },
	dependencies = {
		"nvim-java/lua-async-await",
		"nvim-java/nvim-java-core",
		"nvim-java/nvim-java-test",
		"nvim-java/nvim-java-dap",
		"nvim-java/nvim-java-refactor",
		"MunifTanjim/nui.nvim",
		"neovim/nvim-lspconfig",
		"mfussenegger/nvim-dap",
		{
			"JavaHello/spring-boot.nvim",
			commit = "218c0c26c14d99feca778e4d13f5ec3e8b1b60f0",
			ft = { "java", "yaml", "jproperties" },
		},
	},
	config = function()
		-- Setup nvim-java with Spring Boot support
		require("java").setup({
			-- Startup checks
			checks = {
				nvim_version = true,
				nvim_jdtls_conflict = true, -- Check for conflicts with nvim-jdtls
			},

			-- JDTLS configuration
			jdtls = {
				version = "1.43.0",
			},

			-- Extensions
			lombok = {
				enable = true,
				version = "1.18.40",
			},

			java_test = {
				enable = true,
				version = "0.40.1",
			},

			java_debug_adapter = {
				enable = true,
				version = "0.58.2",
			},

			spring_boot_tools = {
				enable = true, -- Enable Spring Boot Language Server
				version = "1.55.1",
			},

			-- JDK installation
			jdk = {
				auto_install = true,
				version = "17", -- Default to Java 17 (LTS)
			},

			-- Logging
			log = {
				use_console = true,
				use_file = true,
				level = "info", -- Use 'debug' for troubleshooting
				log_file = vim.fn.stdpath("state") .. "/nvim-java.log",
				max_lines = 1000,
				show_location = false,
			},
		})

		-- Enable jdtls via vim.lsp.enable
		-- This integrates with your existing LSP setup
		vim.lsp.enable("jdtls")

		-- Initialize Spring Boot LSP commands
		-- This registers Spring Boot specific commands and handlers
		require("spring_boot").init_lsp_commands()
	end,
}
