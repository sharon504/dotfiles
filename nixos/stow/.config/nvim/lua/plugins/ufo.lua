return {
	"kevinhwang91/nvim-ufo",
	dependencies = "kevinhwang91/promise-async",
	config = function()
		vim.o.foldcolumn = "1" -- '0' is not bad
		vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
		vim.o.foldlevelstart = 99
		vim.o.foldenable = true
		vim.keymap.set("n", "zj", "<cmd>foldopen<CR>", { desc = "Open fold" })
		vim.keymap.set("n", "zk", "<cmd>foldclose<CR>", { desc = "Close fold" })
		vim.keymap.set("n", "zJ", require("ufo").openAllFolds)
		vim.keymap.set("n", "zK", require("ufo").closeAllFolds)
		vim.keymap.set("n", "zl", function()
			local winid = require("ufo").peekFoldedLinesUnderCursor()
			if not winid then
				vim.lsp.buf.hover()
			end
		end, { desc = "Peek Fold" })

		require("ufo").setup({
			provider_selector = function(bufnr, filetype, buftype)
				return { "treesitter", "indent" }
			end,
		})
	end,
}
