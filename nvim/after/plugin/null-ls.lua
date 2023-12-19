local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.black.with({
            filetypes = { "python", },
        }),
        null_ls.builtins.diagnostics.flake8.with({
            filetypes = { "python", },
        }),
        -- null_ls.builtins.diagnostics.mypy.with({
        --     filetypes = { "python", },
        -- }),
        -- null_ls.builtins.diagnostics.ruff.with({
        --     filetypes = { "python", },
        -- }),
        null_ls.builtins.formatting.prettier.with({
            filetypes = { "javascript", "jsx", "css", "typescript", "html", },
        }),
        null_ls.builtins.diagnostics.eslint_d.with({
            filetypes = { "javascript", "typescript", },
        }),
    },

    on_attach = function(client, bufnr)
        if client.supports_method ("textDocument/formatting") then
            vim.api.nvim_clear_autocmds ({
                group = augroup,
                buffer= bufnr,
            })
            vim.api.nvim_create_autocmd("BufWrite Pre", {
                group = augroup,
                buffer= bufnr,
                callback = function ()
                    vim. lsp.buf.format({ bufnr = bufnr })
                end,
            })
        end
    end,
})

