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
