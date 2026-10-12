return {
	"stevearc/conform.nvim",
	opts = {},
	config = function()
		require("conform").setup({
			default_format_opts = { lsp_format = "fallback" },
			format_on_save = {
				timeout_ms = 5000,
			},
			formatters_by_ft = {
				c = { "clang-format" },
				cpp = { "clang-format" },
				lua = { "stylua" },
				go = { "gofmt" },
				elixir = { "mix" },
        javascript = { "prettier" },
        javascriptreact = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
			},
			formatters = {
				["clang-format"] = {
					prepend_args = { "-style=file", "-fallback-style=LLVM" },
				},
			},
		})

		vim.keymap.set("n", "<leader>f", function()
			require("conform").format({ bufnr = 0 })
		end)
	end,
}
