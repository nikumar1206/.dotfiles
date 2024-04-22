local options = {
	lsp_fallback = true,

	formatters_by_ft = {
		javascript = { "prettier" },
		typescript = { "prettier" },
		javascriptreact = { "prettier" },
		typescriptreact = { "prettier" },
		svelte = { "prettier" },
		css = { "prettier" },
		html = { "prettier" },
		json = { "fixjson" },
		yaml = { "prettier" },
		markdown = { "prettier" },
		graphql = { "prettier" },
		lua = { "stylua" },
		python = { "isort", "black" },
		terraform = { "terraform_fmt" },
		tf = { "terraform_fmt" },
		go = { "gofumpt", "golines" },
	},
	format_on_save = {
		lsp_fallback = true,
		async = true,
		timeout_ms = 5000,
	},
}

require("conform").setup(options)
