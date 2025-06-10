return {
	"folke/trouble.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons", "folke/todo-comments.nvim" },
	cmd = "Trouble",
	opts = {},
	keys = {
		{ "<leader>xx", "<cmd>Trouble diagnostics toggle<CR>", desc = "Open/close trouble list" },
		{ "<leader>xw", "<cmd>Trouble workspace_diagnostics toggle<CR>", desc = "Open workspace diagnostics" },
		-- { "<leader>xd", "<cmd>Trouble document_diagnostics toggle<CR>", desc = "Open trouble document diagnostics" },
		{ "<leader>xq", "<cmd>Trouble qflist toggle<CR>", desc = "Open trouble quickfix list" },
		{ "<leader>xl", "<cmd>Trouble loclist toggle<CR>", desc = "Open trouble location list" },
		{ "<leader>xt", "<cmd>TodoTrouble<CR>", desc = "Open todos in trouble" },
	},
}
