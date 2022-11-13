require("nvim-autopairs").setup({})
require("nvim_comment").setup({})

local toggle_linewise_cuurent = function()
	require("Comment.api").toggle.linewise.current()
end

vim.keymap.set("n", "<leader>/", toggle_linewise_cuurent)

require("toggleterm").setup({})
