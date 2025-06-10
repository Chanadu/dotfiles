vim.g.mapleader = " "
vim.g.maplocalleader = " "

local keymap = vim.keymap

keymap.set("n", "<leader>nm", ":nohl<CR>", { desc = "Clear search highlights" })

-- increment decrement numbers
-- keymap.set("n", "<leader>+", "<C-a>", { desc = "Increment number" })
-- keymap.set("n", "<leader>=", "<C-a>", { desc = "Increment number" })
-- keymap.set("n", "<leader>-", "<C-x>", { desc = "Decrement number" })

keymap.set("n", ",", '"0p', { desc = "Paste previously copied content" })
keymap.set("v", ",", '"0p', { desc = "Paste previously copied content" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" })
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" })
keymap.set("n", "<leader>se", "<C-w>=", { desc = "Makes splits equal size" })
keymap.set("n", "<leader>sx", "<cmd>close<CR>", { desc = "Close current split" })

--tab management
-- keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" })
-- keymap.set("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" })
-- keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" })
-- keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" })
-- keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" })

vim.g.neovide_scale_factor = 1.0
local change_scale_factor = function(delta)
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
end
local scale_change_factor = 1.10
vim.keymap.set("n", "<C-=>", function()
	change_scale_factor(scale_change_factor)
end)
vim.keymap.set("n", "<C-->", function()
	change_scale_factor(1 / scale_change_factor)
end)

vim.g.neovide_position_animation_length = 0.1
vim.g.neovide_cursor_animation_length = 0.00
vim.g.neovide_cursor_trail_size = 0
vim.g.neovide_cursor_animate_in_insert_mode = false
vim.g.neovide_cursor_animate_command_line = false
vim.g.neovide_scroll_animation_far_lines = 0
vim.g.neovide_scroll_animation_length = 0.00
