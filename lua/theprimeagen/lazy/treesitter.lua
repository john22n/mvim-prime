return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local treesitter = require("nvim-treesitter")
            treesitter.setup()
            treesitter.install({
                "vimdoc", "javascript", "typescript", "tsx", "c", "lua", "rust",
                "jsdoc", "bash", "go", "markdown", "markdown_inline",
                "python", "hcl",
            })

            -- Highlighting is now enabled via vim.treesitter.start()
            vim.api.nvim_create_autocmd("FileType", {
                callback = function()
                    pcall(vim.treesitter.start)
                end,
            })

            -- For markdown with additional regex highlighting
            vim.api.nvim_create_autocmd("FileType", {
                pattern = "markdown",
                callback = function()
                    vim.bo.syntax = "on"
                end,
            })

            vim.treesitter.language.register("templ", "templ")
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        opts = {
            enable = true,
            max_lines = 0,
            line_numbers = true,
            multiline_threshold = 20,
            trim_scope = 'outer',
            mode = 'cursor',
        },
    }
}
