return {
    "nvim-telescope/telescope.nvim",

    tag = "0.1.5",

    dependencies = {
        "nvim-lua/plenary.nvim"
    },

    config = function()
        require('telescope').setup({
            defaults = {
            file_ignore_patterns = {
                "node_modules",
                "dist",
                "%.git/",
                "build",
                "target",
               },
            }
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        vim.keymap.set('n', '<leader>pws', function()
            local word = vim.fn.expand("<cword>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>pWs', function()
            local word = vim.fn.expand("<cWORD>")
            builtin.grep_string({ search = word })
        end)
        vim.keymap.set('n', '<leader>ps', function()
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        vim.keymap.set('n', '<leader>vh', builtin.help_tags, {})

        -- Git status (staged + unstaged + untracked)
        vim.keymap.set("n", "<leader>pg", function()
          builtin.git_status({
            previewer = true,
            layout_strategy = "horizontal",
            layout_config = { preview_width = 0.6 },
          })
        end, { desc = "Git changed files (status)" })

        -- Git diff vs HEAD (only modified files)
        vim.keymap.set("n", "<leader>pG", function()
          builtin.find_files({
            prompt_title = "Git Diff Files",
            find_command = { "git", "diff", "HEAD", "--name-only" },
            previewer = true,
            layout_strategy = "horizontal",
            layout_config = { preview_width = 0.6 },
          })
        end, { desc = "Git diff files (with preview)" })
  end
}

