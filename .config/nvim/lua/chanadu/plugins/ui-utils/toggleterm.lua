return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<leader>/f", "<cmd>ToggleTerm direction=float<CR>", desc = "Open Floating Terminal" },
		{ "<leader>/h", "<cmd>ToggleTerm direction=horizontal<CR>", desc = "Open Horizontal Terminal" },
	},
	config = function()
		require("toggleterm").setup({
			size = 20,
			hide_numbers = true, -- hide the number column in toggleterm buffers
			shade_filetypes = {},
			shade_terminals = true,
			shading_factor = 1, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
			start_in_insert = true,
			insert_mappings = true, -- whether or not the open mapping applies in insert mode
			persist_size = true,
			direction = "horizontal",
			close_on_exit = true, -- close the terminal window when the process exits
			shell = vim.o.shell, -- change the default shell
			-- This field is only relevant if direction is set to 'float'
			float_opts = {
				-- The border key is *almost* the same as 'nvim_win_open'
				-- see :h nvim_win_open for details on borders however
				-- the 'curved' border is a custom border type
				-- not natively supported but implemented in this plugin.
				border = "single",
				width = 200,
				height = 50,
				winblend = 3,
				highlights = {
					border = "Normal",
					background = "Normal",
				},
			},
		})

		function _G.set_terminal_keymaps()
			local opts = { buffer = 0 }
			vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
		end

		-- if you only want these mappings for toggle term use term://*toggleterm#* instead
		vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
	end,
}
