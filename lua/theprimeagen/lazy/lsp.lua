return {
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/nvim-cmp",
        "j-hui/fidget.nvim",
    },

    config = function()
        vim.lsp.config("*", {
            capabilities = require("cmp_nvim_lsp").default_capabilities(),
        })

        require("fidget").setup({})
        require("mason").setup()

        vim.lsp.config("pyright", {
            root_markers = { "pyrightconfig.json", "pyproject.toml", ".git" },
            before_init = function(_, config)
                local root_dir = config.root_dir or vim.fn.getcwd()
                local python_paths = {
                    root_dir .. "/.venv/bin/python",
                    root_dir .. "/venv/bin/python",
                }

                if vim.env.VIRTUAL_ENV then
                    table.insert(python_paths, 1, vim.env.VIRTUAL_ENV .. "/bin/python")
                end

                for _, python_path in ipairs(python_paths) do
                    if vim.fn.executable(python_path) == 1 then
                        config.settings.python.pythonPath = python_path
                        break
                    end
                end
            end,
            settings = { python = {} },
        })

        vim.lsp.config("zls", {
            root_markers = { ".git", "build.zig", "zls.json" },
            settings = {
                zls = {
                    enable_inlay_hints = true,
                    enable_snippets = true,
                    warn_style = true,
                },
            },
        })
        vim.g.zig_fmt_parse_errors = 0
        vim.g.zig_fmt_autosave = 0

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    format = {
                        enable = true,
                        defaultConfig = {
                            indent_style = "space",
                            indent_size = "2",
                        },
                    },
                },
            },
        })

        vim.lsp.config("tailwindcss", {
            filetypes = { "html", "css", "scss", "javascript", "javascriptreact", "typescript", "typescriptreact", "vue", "svelte", "heex" },
        })

        vim.lsp.config("ts_ls", {
            filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx" },
            init_options = {
                hostInfo = "neovim",
                tsserver = {
                    fallbackPath = vim.fn.stdpath("data") .. "/mason/packages/typescript-language-server/node_modules/typescript/lib",
                },
            },
            on_attach = function(_, bufnr)
                local group = vim.api.nvim_create_augroup("TypeScriptOrganizeImports" .. bufnr, { clear = true })
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = group,
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.code_action({
                            context = { only = { "source.organizeImports" }, diagnostics = {} },
                            apply = true,
                        })
                    end,
                })
            end,
            settings = {
                typescript = {
                    format = { indentSize = 2, convertTabsToSpaces = true },
                },
                javascript = {
                    format = { indentSize = 2, convertTabsToSpaces = true },
                },
            },
        })

        vim.lsp.config("harper_ls", {
            workspace_required = true,
            filetypes = { "markdown", "gitcommit", "text" },
            settings = {
                ["harper-ls"] = {
                    linters = {
                        SentenceCapitalization = false,
                        SpellCheck = true,
                        RepeatedWords = true,
                        Spaces = true,
                    },
                },
            },
        })

        vim.lsp.config("yamlls", {
            settings = {
                yaml = {
                    validate = true,
                    hover = true,
                    completion = true,
                    schemaStore = { enable = true },
                },
            },
        })

        -- Configure servers before Mason automatically enables installed ones.
        require("mason-lspconfig").setup({
            ensure_installed = {
                "lua_ls",
                "pyright",
                "rust_analyzer",
                "tailwindcss",
                "ts_ls",
                "harper_ls",
                "yamlls",
                "terraformls",
            },
        })

        vim.diagnostic.config({
            float = {
                focusable = false,
                style = "minimal",
                border = "rounded",
                source = "always",
                header = "",
                prefix = "",
            },
        })
    end,
}
