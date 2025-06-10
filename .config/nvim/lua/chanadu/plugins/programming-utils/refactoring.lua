return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	lazy = false,
	config = function()
		require("refactoring").setup()

		local keymap = vim.keymap

		keymap.set("n", "<F5>", "<cmd>Refactor", { desc = "Substitute with motion" })
	end,
}
