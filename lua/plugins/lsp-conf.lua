local on_attach = function(client, bufnr)
    -- nightly
    client.server_capabilities.documentFormattingProvider = false
    client.server_capabilities.documentRangeFormattingProvider = false
    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>")
    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>")
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
    vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
    vim.keymap.set("n", "<space>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>")
    vim.keymap.set("n", "<space>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>")
    vim.keymap.set("n", "<space>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>")
    vim.keymap.set("n", "<space>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
    vim.keymap.set("n", "<space>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
    vim.keymap.set("n", "<space>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
    vim.keymap.set("n", "<space>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")
    vim.keymap.set("n", "[d", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>")
    vim.keymap.set("n", "]d", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>")
    vim.keymap.set("n", "<space>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>")
    vim.keymap.set("n", "<space>f", "<cmd>lua vim.lsp.buf.formatting()<CR>")
    -- utils.load_mappings("lspconfig", { buffer = bufnr })

end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
-- local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())  

capabilities.textDocument.completion.completionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    labelDetailsSupport = true,
    deprecatedSupport = true,
    commitCharactersSupport = true,
    tagSupport = { valueSet = { 1 } },
    resolveSupport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
    },
},
}

vim.opt.completeopt = "menu,menuone,noselect"

-- require("mason").setup()

require("mason").setup {
  ensure_installed = {
    "lua-language-server",
    "gopls",
    "goimports",
  },
}
require("mason-lspconfig").setup()
require("mason-lspconfig").setup_handlers {
    -- golang
    require("lspconfig").gopls.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        -- root_dir = lspconfig.util.root_pattern(".git", "go.mod"),
        flags = {
        debounce_text_changes = 150,
        },
        settings = {
        gopls = {
            gofumpt = true,
            experimentalPostfixCompletions = true,
            staticcheck = true,
            usePlaceholders = true,
        },
        },
    },
    -- lua
    require("lspconfig").sumneko_lua.setup {
        on_attach = on_attach,
        capabilities = capabilities,
        settings = {
            Lua = {
            diagnostics = {
                globals = { "vim" },
            },
            workspace = {
                library = {
                [vim.fn.expand "$VIMRUNTIME/lua"] = true,
                [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
                },
                maxPreload = 100000,
                preloadFileSize = 10000,
            },
            },
        },
        },
        require("lspconfig").rust_analyzer.setup {
            on_attach = on_attach,
            settings = {
              ["rust-analyzer"] = {
                imports = {
                  granularity = {
                    group = "module",
                  },
                  prefix = "self",
                },
                cargo = {
                  buildScripts = {
                    enable = true,
                  },
                },
                procMacro = {
                  enable = true,
                },
              },
            },
          }
}

local cmp = require"cmp"
cmp.setup({
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  }),
  sources = cmp.config.sources({
    { name = "nvim_lsp" },
    { name = "vsnip" },
  }, {
    { name = "buffer" },
  })
})


