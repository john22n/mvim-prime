function ColorMyPencils(color)
    color = color or "everforest"  -- Changed default to everforest
    vim.cmd.colorscheme(color)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
end

return {
    { -- Everforest colorscheme
        "sainnhe/everforest",
        lazy = false,
        priority = 1000,
        config = function()
            -- Configure Everforest settings before loading
            vim.g.everforest_background = "hard"  -- Options: 'soft', 'medium', 'hard'
            vim.g.everforest_enable_italic = 0
            vim.g.everforest_disable_italic_comment = 1
            vim.o.background = "dark"

            -- Apply the colorscheme with transparent background
            ColorMyPencils("everforest")
        end,
    },
}
