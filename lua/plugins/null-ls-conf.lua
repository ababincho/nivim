local null_ls = require("null-ls")
local sources = {
	null_ls.builtins.formatting.rustfmt.with({
		extra_args = { "--edition=2021" },
	}),
	null_ls.builtins.formatting.gofmt,
	null_ls.builtins.formatting.goimports,
	null_ls.builtins.formatting.stylua,
}

-- you can reuse a shared lspconfig on_attach callback here

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				--              -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
				vim.lsp.buf.format({ bufnr = bufnr })
				--    vim.lsp.buf.formatting_sync()
			end,
		})
	end
end

null_ls.setup({
	debug = true,
	sources = sources,
	on_attach = on_attach,
})
