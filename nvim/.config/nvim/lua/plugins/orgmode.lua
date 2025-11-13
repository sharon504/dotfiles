return {
	"nvim-orgmode/orgmode",
	event = "VeryLazy",
	ft = { "org" },
	config = function()
		-- Setup orgmode
		require("orgmode").setup({
			org_agenda_files = "~/WorkDir/orgfiles/**/*",
			org_default_notes_file = "~/WorkDir/orgfiles/refile.org",
			org_startup_folded = "showeverything",

			-- Don't re-fold when editing
			org_adapt_indentation = false,
			-- org_indent_mode = "noindent", -- This often causes fold refresh
		})
	end,
}
