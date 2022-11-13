require("nvim-treesitter.configs").setup({
	highlight = {
		enable = true,
	},
	indent = {
		enable = true,
	},
	ensure_installed = {
		"rust",
		"c",
		"go",
		"gomod",
		"lua",
	},
	ignore_install = {
		"javascript",
	},
	sync_install = true,
	auto_install = false,
})
