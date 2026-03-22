return {
	"hrsh7th/nvim-cmp",
	version = false, -- last release is way too old
	event = "InsertEnter",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"onsails/lspkind.nvim",

		{
			"L3MON4D3/LuaSnip",
			-- follow latest release.
			version = "v2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
			-- install jsregexp (optional!).
			build = "make install_jsregexp",
		},
	},
	opts = function()
		vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })
		local cmp = require("cmp")
		local defaults = require("cmp.config.default")()
		local auto_select = true

		local lspkind = require("lspkind")
		cmp.setup({
			formatting = {
				format = lspkind.cmp_format({
					mode = "symbol", -- show only symbol annotations
					maxwidth = {
						-- prevent the popup from showing more than provided characters (e.g 50 will not show more than 50 characters)
						-- can also be a function to dynamically calculate max width such as
						-- menu = function() return math.floor(0.45 * vim.o.columns) end,
						menu = 50, -- leading text (labelDetails)
						abbr = 50, -- actual suggestion item
					},
					ellipsis_char = "...", -- when popup menu exceed maxwidth, the truncated part would show ellipsis_char instead (must define maxwidth first)
					show_labelDetails = true, -- show labelDetails in menu. Disabled by default

					before = function(_, vim_item)
						-- so that you can provide more controls on popup customization. (See [#30](https://github.com/onsails/lspkind-nvim/pull/30))
						return vim_item
					end,
				}),
			},
		})

		-- Local implementation to replace LazyVim.cmp functions
		local cmp_utils = {
			-- Confirm completion with behavior options
			confirm = function(opts)
				opts = opts or {}
				return function(fallback)
					if cmp.visible() then
						local confirm_opts = {
							behavior = opts.behavior or cmp.ConfirmBehavior.Insert,
							select = opts.select or false,
						}
						cmp.confirm(confirm_opts)
					else
						fallback()
					end
				end
			end,
			-- Handle mapping for snippets and AI
			map = function(actions, fallback)
				return function()
					if cmp.visible() then
						local entry = cmp.get_selected_entry()
						if not entry then
							cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
						else
							cmp.confirm({ select = true })
						end
					elseif vim.snippet and vim.snippet.active() and actions.snippet_forward then
						vim.snippet.jump(1)
					else
						fallback()
					end
				end
			end,
		}

		local function has_words_before()
			if vim.bo[0].buftype == "prompt" then
				return false
			end
			local line, col = unpack(vim.api.nvim_win_get_cursor(0))
			return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
		end

		cmp.setup({
			mapping = {
				["<Tab>"] = vim.schedule_wrap(function(fallback)
					if cmp.visible() and has_words_before() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					else
						fallback()
					end
				end),
			},
		})

		-- Icons for completion items
		local kind_icons = {
			Copilot = " ",
			Text = "󰉿 ",
			Method = "󰆧 ",
			Function = "󰊕 ",
			Constructor = " ",
			Field = " ",
			Variable = "󰀫 ",
			Class = "󰠱 ",
			Interface = " ",
			Module = " ",
			Property = "󰜢 ",
			Unit = "󰑭 ",
			Value = "󰎠 ",
			Enum = " ",
			Keyword = "󰌋 ",
			Snippet = " ",
			Color = "󰏘 ",
			File = "󰈙 ",
			Reference = "󰈇 ",
			Folder = "󰉋 ",
			EnumMember = " ",
			Constant = "󰏿 ",
			Struct = "󰙅 ",
			Event = " ",
			Operator = "󰆕 ",
			TypeParameter = "󰊄 ",
			Default = " ",
		}

		return {
			auto_brackets = {}, -- configure any filetype to auto add brackets
			completion = {
				completeopt = "menu,menuone,noinsert" .. (auto_select and "" or ",noselect"),
			},
			preselect = auto_select and cmp.PreselectMode.Item or cmp.PreselectMode.None,
			mapping = cmp.mapping.preset.insert({
				["<C-b>"] = cmp.mapping.scroll_docs(-4),
				["<C-f>"] = cmp.mapping.scroll_docs(4),
				["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-j>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-k>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
				["<C-l>"] = cmp_utils.confirm({ select = auto_select }),
				["<C-y>"] = cmp_utils.confirm({ select = true }),
				["<S-CR>"] = cmp_utils.confirm({ behavior = cmp.ConfirmBehavior.Replace }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
				["<C-CR>"] = function(fallback)
					cmp.abort()
					fallback()
				end,
				["<tab>"] = vim.schedule_wrap(function(fallback)
					if cmp.visible() and has_words_before() then
						cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
					else
						fallback()
					end
				end),
			}),
			sources = cmp.config.sources({
				{ name = "copilot", group_index = 2 },
				{ name = "lazydev" },
				{ name = "nvim_lsp" },
				{ name = "path" },
			}, {
				{ name = "buffer" },
			}),
			formatting = {
				format = function(_, item)
					if kind_icons[item.kind] then
						item.kind = kind_icons[item.kind] .. item.kind
					end

					local widths = {
						abbr = vim.g.cmp_widths and vim.g.cmp_widths.abbr or 40,
						menu = vim.g.cmp_widths and vim.g.cmp_widths.menu or 30,
					}

					for key, width in pairs(widths) do
						if item[key] and vim.fn.strdisplaywidth(item[key]) > width then
							item[key] = vim.fn.strcharpart(item[key], 0, width - 1) .. "…"
						end
					end

					return item
				end,
			},
			experimental = {
				-- only show ghost text when we show ai completions
				ghost_text = vim.g.ai_cmp and {
					hl_group = "CmpGhostText",
				} or false,
			},
			sorting = defaults.sorting,
		}
	end,
}
