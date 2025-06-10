return {
	"debugloop/telescope-undo.nvim",
	dependencies = {
		{
			"nvim-telescope/telescope.nvim",
			dependencies = { "nvim-lua/plenary.nvim" },
		},
	},
	keys = {
		{ "<leader>u", "<cmd>Telescope undo<cr>", desc = "undo history" },
	},
	opts = {
		extensions = {
			undo = {
				side_by_side = true,
				layout_strategy = "vertical",
				layout_config = {
					preview_height = 0.8,
				},
			},
		},
	},
	config = function(_, opts)
		local telescope = require("telescope")
		telescope.setup(opts)
		telescope.load_extension("undo")
	end,
}
