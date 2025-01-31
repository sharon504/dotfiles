return {
	"saghen/blink.cmp",
	dependencies = {
		{ "saghen/blink.compat", opts = { enable_events = true } },
		{
			"Exafunction/codeium.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
			},
			opts = {},
		},
		"rafamadriz/friendly-snippets",
		{
			"giuxtaposition/blink-cmp-copilot",
		},
		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
	},
	lazy = false,
	version = "v0.*", -- use a release tag to download pre-built binaries

	opts = {
		completion = {
			--   keyword = {
			--     -- 'prefix' will fuzzy match on the text before the cursor
			--     -- 'full' will fuzzy match on the text before *and* after the cursor
			--     -- example: 'foo_|_bar' will match 'foo_' for 'prefix' and 'foo__bar' for 'full'
			--     range = "full",
			--   },
			menu = {
				border = "single",
			},
			documentation = {
				auto_show = true,
				window = {
					border = "single",
				},
			},
			-- Displays a preview of the selected item on the current line
			ghost_text = {
				enabled = true,
			},
		},
		snippets = {
			preset = "luasnip",
			-- This comes from the luasnip extra, if you don't add it, won't be able to
			-- jump forward or backward in luasnip snippets
			-- https://www.lazyvim.org/extras/coding/luasnip#blinkcmp-optional
			expand = function(snippet)
				require("luasnip").lsp_expand(snippet)
			end,
			active = function(filter)
				if filter and filter.direction then
					return require("luasnip").jumpable(filter.direction)
				end
				return require("luasnip").in_snippet()
			end,
			jump = function(direction)
				require("luasnip").jump(direction)
			end,
		},

		sources = {
			default = { "lsp", "path", "snippets", "buffer", "codeium", "copilot" },

			providers = {
				copilot = {
					name = "copilot",
					enabled = true,
					module = "blink-cmp-copilot",
					min_keyword_length = 6,
					score_offset = -100, -- the higher the number, the higher the priority
					async = true,
				},
				codeium = {
					name = "codeium",
					module = "blink.compat.source",
					enabled = true,
					score_offset = 3,
				},
			},
		},
		keymap = {
			["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
			["<C-e>"] = { "hide", "fallback" },

			["<C-l>"] = {
				function(cmp)
					if cmp.snippet_active() then
						return cmp.accept()
					else
						return cmp.select_and_accept()
					end
				end,
				"snippet_forward",
				"fallback",
			},
			["<S-Tab>"] = { "snippet_backward", "fallback" },

			["<C-k>"] = { "select_prev", "fallback" },
			["<C-j>"] = { "select_next", "fallback" },
			["<C-p>"] = { "select_prev", "fallback" },
			["<C-n>"] = { "select_next", "fallback" },

			["<C-b>"] = { "scroll_documentation_up", "fallback" },
			["<C-f>"] = { "scroll_documentation_down", "fallback" },

			["<Left>"] = { "show_signature", "hide_signature", "fallback" },
		},

		appearance = {
			-- Sets the fallback highlight groups to nvim-cmp's highlight groups
			-- Useful for when your theme doesn't support blink.cmp
			-- Will be removed in a future release
			use_nvim_cmp_as_default = true,
			-- Set to 'mono' for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
			-- Adjusts spacing to ensure icons are aligned
			nerd_font_variant = "mono",
		},
	},
	opts_extend = { "sources.default" },
}
