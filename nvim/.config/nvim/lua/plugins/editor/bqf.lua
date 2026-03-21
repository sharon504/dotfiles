return {
	"kevinhwang91/nvim-bqf",
	ft = "qf",
	dependencies = {
		{
			"junegunn/fzf",
			build = function()
				vim.fn["fzf#install"]()
			end,
		},
	},
	opts = {
		auto_enable = true,
		auto_resize_height = true, -- Highly recommended enable
		preview = {
			win_height = 12,
			win_vheight = 12,
			delay_syntax = 80,
			border = { "┏", "━", "┓", "┃", "┛", "━", "┗", "┃" },
			show_title = false,
			should_preview_cb = function(bufnr, qwinid)
				local ret = true
				local bufname = vim.api.nvim_buf_get_name(bufnr)
				local fsize = vim.fn.getfsize(bufname)
				if fsize > 100 * 1024 then
					-- Skip file larger than 100k
					ret = false
				elseif bufname:match("^fugitive://") then
					-- Skip fugitive buffer
					ret = false
				end
				return ret
			end,
		},
		-- Make `drop` and `tab drop` to the quickfix valid
		func_map = {
			drop = "o",
			openc = "O",
			split = "<C-s>",
			vsplit = "<C-v>",
			tab = "t",
			tabb = "T",
			tabc = "<C-t>",
			tabdrop = "",
			ptogglemode = "z,",
			pscrollup = "<C-b>",
			pscrolldown = "<C-f>",
			pscrollorig = "zo",
			prevfile = "<C-p>",
			nextfile = "<C-n>",
			prevhist = "<",
			nexthist = ">",
			stoggleup = "<S-Tab>",
			stoggledown = "<Tab>",
			stogglevm = "<Tab>",
			stogglebuf = "'<Tab>",
			sclear = "z<Tab>",
			filter = "zn",
			filterr = "zN",
			fzffilter = "zf",
		},
		filter = {
			fzf = {
				action_for = { ["ctrl-s"] = "split", ["ctrl-t"] = "tab drop" },
				extra_opts = { "--bind", "ctrl-o:toggle-all", "--prompt", "> " },
			},
		},
	},
}
