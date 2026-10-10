return {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
        "tpope/vim-dadbod",
        {
            "kristijanhusak/vim-dadbod-completion",
            ft = { "sql", "mysql", "plsql" },
        },
    },
    cmd = {
        "DB",
        "DBUI",
        "DBUIToggle",
        "DBUIAddConnection",
        "DBUIFindBuffer",
    },
    keys = {
        { "<leader>db", "<cmd>DBUIToggle<cr>", desc = "Toggle database browser" },
    },
    init = function()
        vim.g.db_ui_use_nerd_fonts = 1
    end,
}
