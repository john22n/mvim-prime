return {
  'https://github.com/fresh2dev/zellij.vim',
  -- Pin version to avoid breaking changes.
  -- tag = '0.3.*',
  lazy = false,
  init = function()
    -- Make <C-h/j/k/l> move panes/tabs (not just focus).
    vim.g.zellij_navigator_move_focus_or_tab = 1
    -- Uncomment to disable default <C-h/j/k/l> mappings entirely:
    -- vim.g.zellij_navigator_no_default_mappings = 1
  end,
  keys = {
    -- Open panes
    { '<leader>zjf', '<cmd>ZellijNewPane<cr>',       desc = 'Zellij: floating pane' },
    { '<leader>zjo', '<cmd>ZellijNewPaneSplit<cr>',  desc = 'Zellij: pane below' },
    { '<leader>zjv', '<cmd>ZellijNewPaneVSplit<cr>', desc = 'Zellij: pane right' },

    -- Run command in new pane
    {
      '<leader>zjrf',
      function()
        local cmd = vim.fn.input('Command: ')
        if cmd ~= '' then vim.cmd('ZellijNewPane ' .. cmd) end
      end,
      desc = 'Zellij: run in floating pane',
    },
    {
      '<leader>zjro',
      function()
        local cmd = vim.fn.input('Command: ')
        if cmd ~= '' then vim.cmd('ZellijNewPaneSplit ' .. cmd) end
      end,
      desc = 'Zellij: run in pane below',
    },
    {
      '<leader>zjrv',
      function()
        local cmd = vim.fn.input('Command: ')
        if cmd ~= '' then vim.cmd('ZellijNewPaneVSplit ' .. cmd) end
      end,
      desc = 'Zellij: run in pane right',
    },
  },
  config = function()
    -- Rename the current Zellij tab to match Neovim's cwd.
    local group = vim.api.nvim_create_augroup('ZellijTabRename', { clear = true })
    vim.api.nvim_create_autocmd({ 'DirChanged', 'BufEnter' }, {
      group = group,
      callback = function()
        local name = vim.fn.fnamemodify(vim.fn.getcwd(), ':t')
        vim.fn.system({ 'zellij', 'action', 'rename-tab', name })
      end,
    })
  end,
}
