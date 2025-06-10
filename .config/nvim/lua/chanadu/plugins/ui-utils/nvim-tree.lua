return {
	"nvim-tree/nvim-tree.lua",
	dependencies = "nvim-tree/nvim-web-devicons",
	config = function()
		local nvimtree = require("nvim-tree")

		-- recomended settings from the nvim-tree documentation
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1

		-- local HEIGHT_RATIO = 0.8 -- You can change this
		-- local WIDTH_RATIO = 0.5 -- You can change this too
		nvimtree.setup({
			sync_root_with_cwd = true,
			respect_buf_cwd = true,
			update_focused_file = {
				enable = true,
				update_root = true,
			},

			hijack_cursor = true,

			view = {
				width = 35,
				relativenumber = true,
			},

			renderer = {
				add_trailing = true,
				indent_markers = {
					enable = true,
				},
			},

			actions = {
				open_file = {
					window_picker = {
						enable = false,
					},
				},
			},
			filters = {
				custom = { ".DS_STORE" },
			},
			git = {
				ignore = false,
			},
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>ew", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
		keymap.set(
			"n",
			"<leader>ef",
			"<cmd>NvimTreeFindFile<CR>",
			{ desc = "Select file explorer with current working file" }
		)
		keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapseKeepBuffers<CR>", { desc = "Collapse file explorer" })
		keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" })

		-- local tree_api = require("nvim-tree")
		-- local tree_view = require("nvim-tree.view")
		local api = require("nvim-tree.api")
		api.events.subscribe(api.events.Event.FileCreated, function(file)
			vim.cmd("edit " .. file.fname)
		end)
	end,
}
