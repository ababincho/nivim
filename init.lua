require('plugins')
require('mappings')

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.visualbell = true
vim.opt.showtabline = 2
vim.opt.laststatus = 3
vim.opt.showmatch = true
vim.opt.matchtime = 1

vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
    pattern = { "*.fs", "*.fsx", "*.fsi" },
    command = "set filetype=fsharp",
})
