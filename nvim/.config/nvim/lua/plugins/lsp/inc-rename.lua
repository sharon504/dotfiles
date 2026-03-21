return {
	"smjonas/inc-rename.nvim",
	cmd = "IncRename",
	opts = {
		-- Shows a preview of the rename changes in a floating window
		input_buffer_type = "dressing",
		-- Whether to display a preview of the changes
		preview_empty_name = false,
		-- Whether to save after a successful rename
		save_in_cmdline = false,
	},
}
