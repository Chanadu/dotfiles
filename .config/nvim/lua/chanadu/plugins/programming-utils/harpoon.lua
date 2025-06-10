return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
	config = function()
		local harpoon = require("harpoon")
		harpoon.setup({
			global_settings = {
				save_on_toggle = true,
				save_on_change = true,
				hide_filename = true,
				hide_tab_numbers = true,
				term = {
					position = "top",
					size = 10,
				},
			},
		})

		harpoon:extend({
			UI_CREATE = function(cx)
				vim.keymap.set("n", "<C-v>", function()
					harpoon.ui:select_menu_item({ vsplit = true })
				end, { buffer = cx.bufnr })

				vim.keymap.set("n", "<C-h>", function()
					harpoon.ui:select_menu_item({ split = true })
				end, { buffer = cx.bufnr })

				-- vim.keymap.set("n", "<C-t>", function()
				-- 	harpoon.ui:select_menu_item({ tabedit = true })
				-- end, { buffer = cx.bufnr })
			end,
		})

		local keymap = vim.keymap

		keymap.set("n", "<leader>a", function()
			harpoon:list():add()
			print("Added file to harpoon")
		end, { desc = "Add file to harpoon" })

		keymap.set("n", "<leader>h", function()
			harpoon.ui:toggle_quick_menu(harpoon:list())
		end, { desc = "Open harpoon window" })

		keymap.set("n", "<leader>1", function()
			harpoon:list():select(1)
		end, { desc = "Select harpoon item 1" })

		keymap.set("n", "<leader>2", function()
			harpoon:list():select(2)
		end, { desc = "Select harpoon item 2" })

		keymap.set("n", "<leader>3", function()
			harpoon:list():select(3)
		end, { desc = "Select harpoon item 3" })

		keymap.set("n", "<leader>4", function()
			harpoon:list():select(4)
		end, { desc = "Select harpoon item 4" })

		keymap.set("n", "<leader>5", function()
			harpoon:list():select(5)
		end, { desc = "Select harpoon item 5" })

		keymap.set("n", "<leader>6", function()
			harpoon:list():select(6)
		end, { desc = "Select harpoon item 6" })

		keymap.set("n", "<leader>7", function()
			harpoon:list():select(7)
		end, { desc = "Select harpoon item 7" })

		keymap.set("n", "<leader>8", function()
			harpoon:list():select(8)
		end, { desc = "Select harpoon item 8" })

		keymap.set("n", "<leader>9", function()
			harpoon:list():select(9)
		end, { desc = "Select harpoon item 9" })

		-- Toggle previous & next buffers stored within Harpoon list
		-- keymap.set("n", "<leader>hk", function()
		-- 	harpoon:list():prev()
		-- end)
		-- keymap.set("n", "<leader>hj", function()
		-- 	harpoon:list():next()
		-- end)
	end,
}
