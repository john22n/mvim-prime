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
                "^./dist/",
                "%.git/",
                "build",
                "target",
                "yarn.lock"
               },
            }
        })

        local builtin = require('telescope.builtin')
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})

        -- Search for a word (ask for input)
        vim.keymap.set("n", "<leader>pw", function()
          builtin.live_grep({
            prompt_title = "Search Word",
          })
        end, { desc = "Search for word in project" })

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

        vim.keymap.set("v", "<leader>pw", function()
          local builtin = require("telescope.builtin")

          -- Get selection range
          local start_pos = vim.fn.getpos("'<")
          local end_pos   = vim.fn.getpos("'>")

          local start_line, start_col = start_pos[2], start_pos[3]
          local end_line, end_col     = end_pos[2], end_pos[3]

          -- Get all lines in the range
          local lines = vim.fn.getline(start_line, end_line)

          if #lines == 0 then return end

          -- Trim text to selection columns
          lines[1] = string.sub(lines[1], start_col)
          lines[#lines] = string.sub(lines[#lines], 1, end_col)

          -- Merge into single search string
          local selection = table.concat(lines, " ")

          -- Cleanup whitespace, remove newlines
          selection = selection:gsub("\n", " "):gsub("%s+", " "):gsub("^%s+", ""):gsub("%s+$", "")

          builtin.live_grep({
            default_text = selection,
            prompt_title = "Search Selected Text",
          })
        end, { desc = "Search selected text in project" })

  end
}

