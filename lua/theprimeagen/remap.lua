-- Set space as the leader key (prefix for custom mappings)
vim.g.mapleader = " "

-- Open netrw file explorer in current window
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Move selected lines down in visual mode (and re-indent)
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")

-- Move selected lines up in visual mode (and re-indent)
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Run Plenary test on the current file
vim.api.nvim_set_keymap("n", "<leader>tf", "<Plug>PlenaryTestFile", { noremap = false, silent = false })

-- Join lines but keep cursor in place (using mark z)
vim.keymap.set("n", "J", "mzJ`z")

-- Scroll down half page and center cursor on screen
vim.keymap.set("n", "<C-d>", "<C-d>zz")

-- Scroll up half page and center cursor on screen
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Go to next search result, center screen, and open folds
vim.keymap.set("n", "n", "nzzzv")

-- Go to previous search result, center screen, and open folds
vim.keymap.set("n", "N", "Nzzzv")

-- Format current paragraph and return cursor to original position
vim.keymap.set("n", "=ap", "ma=ap'a")

-- Restart LSP servers (useful when LSP gets stuck)
vim.keymap.set("n", "<leader>zig", "<cmd>LspRestart<cr>")

-- Paste over selection without losing yanked text (deletes to black hole register first)
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Yank to system clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

-- Yank entire line to system clipboard
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Delete to black hole register (don't overwrite yank register)
vim.keymap.set({ "n", "v" }, "<leader>d", "\"_d")

-- Use Ctrl-C as Escape in insert mode
vim.keymap.set("i", "<C-c>", "<Esc>")

-- Disable Ex mode (Q does nothing)
vim.keymap.set("n", "Q", "<nop>")

-- Open tmux-sessionizer in a new tmux window for project switching
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")

-- Open tmux-sessionizer in a vertical split using session 0
vim.keymap.set("n", "<M-h>", "<cmd>silent !tmux-sessionizer -s 0 --vsplit<CR>")

-- Open tmux-sessionizer in a new window using session 0
vim.keymap.set("n", "<M-H>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")

-- Navigate to next item in quickfix list and center
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")

-- Navigate to previous item in quickfix list and center
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")

-- Navigate to next item in location list and center
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")

-- Navigate to previous item in location list and center
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Search and replace word under cursor globally (with confirmation prompt ready)
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Make current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Decrease indent in normal mode
vim.keymap.set('n', '<S-Tab>', '<<', { noremap = true, silent = true })

-- Decrease indent in visual mode and reselect
vim.keymap.set('v', '<S-Tab>', '<gv', { noremap = true, silent = true })

-- Increase indent in visual mode and reselect
vim.keymap.set('v', '<Tab>', '>gv', { noremap = true, silent = true })

-- Increase indent in normal mode
vim.keymap.set('n', '<Tab>', '>>', { noremap = true, silent = true })

-- Open vertical split of current buffer
vim.keymap.set('n', '<leader>v', '<cmd>vsplit<CR>', { desc = "Open vertical split to the right" })

-- Open Neovim config file for editing
vim.keymap.set('n', '<leader>vpp', '<cmd>e $MYVIMRC<CR>', { noremap = true, silent = true })

-- Insert Go error handling snippet (return err)
vim.keymap.set("n", "<leader>ee", "oif err != nil {<CR>}<Esc>Oreturn err<Esc>")

-- Insert Go testify assert.NoError snippet
vim.keymap.set("n", "<leader>ea", "oassert.NoError(err, \"\")<Esc>F\";a")

-- Insert Go error handling snippet with log.Fatalf
vim.keymap.set("n", "<leader>ef", "oif err != nil {<CR>}<Esc>Olog.Fatalf(\"error: %s\\n\", err.Error())<Esc>jj")

-- Insert Go error handling snippet with logger.Error
vim.keymap.set("n", "<leader>el", "oif err != nil {<CR>}<Esc>O.logger.Error(\"error\", \"error\", err)<Esc>F.;i")

-- Start cellular-automaton "make it rain" animation (fun visual effect)
vim.keymap.set("n", "<leader>ca", function()
    require("cellular-automaton").start_animation("make_it_rain")
end)

-- Source current file (Lua/Vim) or show instructions for shell files
vim.keymap.set("n", "<leader><leader>", function()
    local ft = vim.bo.filetype
    if ft == "lua" or ft == "vim" then
        vim.cmd("so")
    elseif ft == "zsh" or ft == "bash" or ft == "sh" then
        print("Run 'source " .. vim.fn.expand("%:p") .. "' in your terminal")
    else
        print("Don't know how to source ." .. ft .. " files")
    end
end)

-- Show diagnostic float window for current line
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

-- Send all diagnostics to the location list
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
