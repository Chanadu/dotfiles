return {
	"lukas-reineke/indent-blankline.nvim",
	version = "v2.20.8",
	event = { "BufReadPre", "BufnewFile" },
	main = "ibl",
	opts = {},
	config = function()
		-- local highlight = {
		-- 	"RainbowBlue",
		-- 	"RainbowRed",
		-- 	"RainbowGreen",
		-- 	"RainbowYellow",
		-- 	"RainbowOrange",
		-- 	"RainbowViolet",
		-- 	"RainbowCyan",
		-- }

		-- local hooks = require("ibl.hooks")
		-- -- create the highlight groups in the highlight setup hook, so they are reset
		-- -- every time the colorscheme changes
		-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
		-- 	vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
		-- 	vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
		-- 	vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
		-- 	vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
		-- 	vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
		-- 	vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
		-- 	vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
		-- end)
		local hl_list = {}
		for i, color in pairs({ "#E06C75", "#E5C07B", "#61AFEF", "#D19A66", "#98C379", "#C678DD", "#56B6C2" }) do
			local name = "IndentBlanklineIndent" .. i
			vim.api.nvim_set_hl(0, name, { fg = color })
			table.insert(hl_list, name)
		end
		require("indent_blankline").setup({
			-- extra stuff
			char_highlight_list = hl_list,
			-- extra stuff
		}) -- end)

		-- require('ibl').setup {
		-- 	char_highlight_list = highlight,
		-- }
	end,
}
