return {
	"rmagatti/auto-session",
	lazy = false,

	---enables autocomplete for opts
	---@module "auto-session"
	---@type AutoSession.Config
	opts = {
		suppressed_dirs = { "~/", "~/Projects", "~/Downloads", "/" },

		-- log_level = 'debug',
	},
	config = function(_, opts)
		require("auto-session").setup({
			bypass_save_filetypes = { "alpha", "nvim-tree" },
		})
	end,
}
