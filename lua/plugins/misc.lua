require("nvim-autopairs").setup({})
require("nvim_comment").setup({
	-- create_mappings = false,
	--	line_mapping = "<C-/>",
})

-- local toggle_linewise_cuurent = function()
-- 	require("Comment.api").toggle.linewise.current()
-- end

vim.keymap.set("n", "<leader>/", "")

require("toggleterm").setup({})

-- Vimspector options
-- vim.cmd([[
-- let g:vimspector_sidebar_width = 85
-- let g:vimspector_bottombar_height = 15
-- let g:vimspector_terminal_maxwidth = 70
-- ]])
