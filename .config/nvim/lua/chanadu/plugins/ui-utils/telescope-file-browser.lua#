return {
	"nvim-telescope/telescope-file-browser.nvim",
	dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")
		telescope.setup({
			defaults = {
				theme = "center",
			},

			extensions = {
				file_browser = {
					-- disables netrw and use telescope-file-browser in its place
					hijack_netrw = true,

					depth = 10,
					mappings = {
						i = {
							["<C-k>"] = actions.move_selection_previous,
							["<C-j>"] = actions.move_selection_next,
							-- ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
						},
					},
				},
			},
		})
		local keymap = vim.keymap
		-- keymap.set("n", "<leader>ff", "<cmd>Telescope file_browser<cr>", { desc = "Open Telescope File Browser" })
		-- keymap.set(
		-- 	"n",
		-- 	"<leader>ff",
		-- 	"<cmd>Telescope file_browser path=%:p:h select_buffer=true<cr>",
		-- 	{ desc = "Open Telescope File Browser with select_buffer" }
		-- )
		-- To get telescope-file-browser loaded and working with telescope,
		-- you need to call load_extension, somewhere after setup function:
		telescope.load_extension("file_browser")
	end,
}
