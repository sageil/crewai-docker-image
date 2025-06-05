return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		opts = { direction = "float" },
		keys = {
			{ "<C-/>", "<cmd>ToggleTerm<cr>", desc = "Open ToggleTerm" },
		},
		float_opts = { border = "curved" },
		win = { border = "rounded" },
		autochdir = true,
	},
}
