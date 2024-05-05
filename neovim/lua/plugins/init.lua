return {
	{
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("configs.conform")
		end,
	},
	{
		"nvim-tree/nvim-tree.lua",
		opts = {
			git = {
				enable = true,
			},
			-- filters = {
			-- 	dotfiles = true,
			-- 	custom = { "^.git$" },
			-- },
		},
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = {},
		opts = {
			inlay_hints = { enabled = true },
			codelens = { enabled = false },
		},
		config = function()
			require("nvchad.configs.lspconfig")
			require("configs.lspconfig")
		end, -- Override to setup mason-lspconfig
	},
	{
		"williamboman/mason.nvim",
		opts = {
			ensure_installed = {
				"gopls",
				"eslint-lsp",
				"js-debug-adapter",
				"prettier",
				"typescript-language-server",
				"black",
				"debugpy",
			},
		},
	},
	{
		"max397574/better-escape.nvim",
		event = "InsertEnter",
		config = function()
			require("better_escape").setup({
				keys = function()
					return "<Esc>"
				end,
			})
		end,
	},
	{
		"vim-crystal/vim-crystal",
		ft = "crystal",
	},
	{
		"olexsmir/gopher.nvim",
		ft = "go",
		config = function(_, opts)
			require("gopher").setup(opts)
			-- require("core.utils").load_mappings("gopher")
		end,
		build = function()
			vim.cmd([[silent! GoInstallDeps]])
		end,
	},
	{ "embark-theme/vim" },
	{
		"nvim-tree/nvim-web-devicons",
		lazy = false,
		config = function()
			require("nvim-web-devicons").setup({
				-- your personnal icons can go here (to override)
				-- you can specify color or cterm_color instead of specifying both of them
				-- DevIcon will be appended to `name`
				override = {
					zsh = {
						icon = "",
						color = "#428850",
						cterm_color = "65",
						name = "Zsh",
					},
					rs = {
						icon = "󱘗",
						color = "#C58C6E",
						cterm_color = "65",
						name = "Rust",
					},
				},
				-- globally enable different highlight colors per icon (default to true)
				-- if set to false all icons will have the default icon's color
				color_icons = true,
				-- globally enable default icons (default to false)
				-- will get overriden by `get_icons` option
				default = false,
				-- globally enable "strict" selection of icons - icon will be looked up in
				-- different tables, first by filename, and if not found by extension; this
				-- prevents cases when file doesn't have any extension but still gets some icon
				-- because its name happened to match some extension (default to false)
				strict = false,
				-- same as `override` but specifically for overrides by filename
				-- takes effect when `strict` is true
				override_by_filename = {
					[".gitignore"] = {
						icon = "",
						color = "#f1502f",
						name = "Gitignore",
					},
				},
				-- same as `override` but specifically for overrides by extension
				-- takes effect when `strict` is true
				override_by_extension = {
					["log"] = {
						icon = "",
						color = "#81e043",
						name = "Log",
					},
				},
			})
		end,
	},
	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
		end,
	},
	{
		"mfussenegger/nvim-lint",
		event = "VeryLazy",
		config = function()
			require("configs.lint")
		end,
	},
	{
		"kylechui/nvim-surround",
		version = "*", -- Use for stability; omit to use `main` branch for the latest features
		event = "VeryLazy",
		config = function()
			require("nvim-surround").setup({
				-- Configuration here, or leave empty to use defaults
			})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		opts = {
			user_default_options = {
				tailwind = true,
			},
			filetypes = { "css", "javascript", "html" },
		},
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require("configs.cmp")
		end,
	},
	{
		"folke/trouble.nvim",
		lazy = false,
		cmd = { "Trouble", "TroubleToggle", "TodoTrouble" },
		dependencies = {
			{
				"folke/todo-comments.nvim",
				opts = {},
			},
			{ "nvim-tree/nvim-web-devicons" },
		},
		opts = {},
		init = function()
			local map = vim.keymap.set

			map("n", "<leader>t", "<CMD>TroubleToggle<CR>", { desc = "Toggle diagnostics" })
			map(
				"n",
				"<leader>td",
				"<CMD>TodoTrouble keywords=TODO,FIX,FIXME,BUG,TEST,NOTE<CR>",
				{ desc = "Todo/Fix/Fixme" }
			)
		end,
	},
	{
		"roobert/search-replace.nvim",
		lazy = false,
		config = function()
			require("search-replace").setup({
				default_replace_single_buffer_options = "gcI",
				default_replace_multi_buffer_options = "egcI",
			})
		end,
	},
	{
		"sindrets/diffview.nvim",
		lazy = false,
		opts = {},
		view = {
			default = {
				layout = "diff2_horizontal",
				winbar_info = true,
			},
		},
	},
	{
		"nvim-treesitter/nvim-treesitter",
		opts = {
			ensure_installed = {
				"vim",
				"lua",
				"vimdoc",
				"html",
				"css",
				"javascript",
				"typescript",
				"tsx",
				"c",
				"markdown",
				"markdown_inline",
				"hcl",
				"terraform",
				"python",
			},
		},
	},
	{
		"ray-x/lsp_signature.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, _)
			require("lsp_signature").setup({
				bind = true, -- This is mandatory, otherwise border config won't get registered.
				handler_opts = {
					border = "rounded",
				},
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && npm install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},
	{
		"mistricky/codesnap.nvim",
		build = "make",
		lazy = false,
		config = function()
			require("codesnap").setup({
				watermark = "",
			})
		end,
	},
	{
		{
			"NeogitOrg/neogit",
			ft = { "diff" },
			cmd = "Neogit",
			dependencies = {
				"sindrets/diffview.nvim",
				"nvim-lua/plenary.nvim",
			},
			opts = {
				signs = { section = { "", "" }, item = { "", "" } },
				disable_commit_confirmation = true,
				integrations = { diffview = true },
			},
		},
	},
	{
		"onsails/lspkind.nvim",
		lazy = false,
		config = function()
			require("lspkind").init({
				symbol_map = {
					Array = "",
					Boolean = "󰨙",
					Class = "",
					Codeium = "󰘦",
					Color = "",
					Control = "",
					Collapsed = ">",
					Constant = "󰯱",
					Constructor = "",
					Copilot = "",
					Enum = "󰯹",
					EnumMember = "",
					Event = "",
					File = "",
					Folder = "",
					Function = "󰡱",
					Interface = "󰰅",
					Key = "",
					Keyword = "󱕴",
					Module = "",
					Method = "",
					Namespace = "󰰔",
					Null = "",
					Number = "󰰔",
					Object = "󰲟",
					Operator = "",
					Package = "󰰚",
					Property = "󰲽",
					Reference = "󰰠",
					Snippet = "",
					String = "",
					Struct = "󰰣",
					TabNine = "󰏚",
					Text = "󰷾",
					TypeParameter = "󰰦",
					Unit = "󱜥",
					Value = "",
					Variable = "󰫧",
				},
			})
		end,
	},
	{
		"luochen1990/rainbow",
		lazy = false,
	},
}
