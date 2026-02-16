return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function()
            require("nvim-treesitter.configs").setup({
                ensure_installed = {
                    "vimdoc", "javascript", "typescript", "c", "lua", "rust",
                    "jsdoc", "bash", "go",
                },
                sync_install = false,
                auto_install = true,
                indent = {
                    enable = true
                },
                highlight = {
                    enable = true,
                    additional_vim_regex_highlighting = { "markdown" },
                },
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
