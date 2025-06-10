return {
	"catgoose/nvim-colorizer.lua",
	event = "BufReadPre",
	opts = {
		user_commands = true,
		user_default_options = {
			names = false,
			tailwind = "both",
			rgb_fn = true,
			hsl_fn = true,
			css = true,
			css_fn = true,
		},
	},
}
