return {
	"scottmckendry/cyberdream.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("cyberdream").setup({
			-- Recommended - see "Configuring" below for more config options
			transparent = true,
			italic_comments = true,
			hide_fillchars = true,
			borderless_telescope = true,
			terminal_colors = true,
		})
		vim.cmd("colorscheme cyberdream") -- set the colorscheme
	end,
	"folke/tokyonight.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		require("tokyonight").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			style = "night", -- The theme comes in three styles, `storm`, `moon`, and `night`
			light_style = "day", -- The theme is used when the background is set to light
			terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
			styles = {
				-- Style to be applied to different syntax groups
				-- Value is any valid attr-list value for `:help nvim_set_hl`
				comments = { italic = true },
				keywords = { italic = true },
				functions = {},
				variables = {},
				-- Background styles. Can be "dark", "transparent" or "normal"
				sidebars = "dark", -- style for sidebars, see below
				floats = "dark", -- style for floating windows
			},
			sidebars = { "qf", "help" }, -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
			floats = { "lsp", "notify", "diff", "telescope" }, -- Set a darker background on floating windows. For example: `{ "lsp", "telescope", "notify", "mason", "lspinfo" }`
			dim_inactive = true, -- dim inactive splits
			lualine_bold = false, -- bold the lualine theme
			lsp_trouble = false, -- enable the lsp-trouble plugin (to display lsp diagnostics)
			-- Add any other custom lua modules you wish to have their colors automatically set
			modules = {
				"which-key",
				"indent-blankline",
				-- "nvim-tree",
				-- "lspsaga",
				"bufferline",
				-- "dashboard",
				"toggleterm",
				-- "notify",
				"neogit",
				"cmp",
				"lazygit",
				"mason",
				"lazydocker",
				"nvim-cmp",
				"gitsigns",
				"telescope",
				-- "nvim-tree",
				-- "fidget",
			},
		})
		-- vim.cmd("colorscheme tokyonight-night")
	end,
}
