return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("yamlls", {
        settings = {
          yaml = {
            validate = true,
          },
        },
      })

      vim.lsp.enable("yamlls")
    end,
  },
}
