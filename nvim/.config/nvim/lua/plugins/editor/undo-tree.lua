return {
	"mbbill/undotree",
	config = function()
		vim.opt.undofile = true
		vim.keymap.set("n", "<leader><F5>", vim.cmd.UndotreeToggle, { desc = "Toggle undo tree" })
	end,
}
