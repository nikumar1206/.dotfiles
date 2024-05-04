local cmp = require("cmp")
local lspkind = require("lspkind")

vim.cmd([[highlight CmpGhostText guifg=#888888]])

local lspkind_comparator = function(conf)
	local lsp_types = require("cmp.types").lsp
	return function(entry1, entry2)
		if entry1.source.name ~= "nvim_lsp" then
			if entry2.source.name == "nvim_lsp" then
				return false
			else
				return nil
			end
		end
		local kind1 = lsp_types.CompletionItemKind[entry1:get_kind()]
		local kind2 = lsp_types.CompletionItemKind[entry2:get_kind()]
		if kind1 == "Variable" and entry1:get_completion_item().label:match("%w*=") then
			kind1 = "Parameter"
		end
		if kind2 == "Variable" and entry2:get_completion_item().label:match("%w*=") then
			kind2 = "Parameter"
		end

		local priority1 = conf.kind_priority[kind1] or 0
		local priority2 = conf.kind_priority[kind2] or 0
		if priority1 == priority2 then
			return nil
		end
		return priority2 < priority1
	end
end

local label_comparator = function(entry1, entry2)
	return entry1.completion_item.label < entry2.completion_item.label
end

local function border(hl_name)
	return {
		{ "╭", hl_name },
		{ "─", hl_name },
		{ "╮", hl_name },
		{ "│", hl_name },
		{ "╯", hl_name },
		{ "─", hl_name },
		{ "╰", hl_name },
		{ "│", hl_name },
	}
end

cmp.setup({
	formatting = {
		-- kind is icon, abbr is completion name, menu is [Function]
		fields = { "kind", "menu", "abbr" },
		format = function(_, item)
			local icons = lspkind.symbol_map
			local icon = " " .. icons[item.kind] .. " "
			-- local kind = " " .. "|" .. item.kind .. "|" .. " "

			item.kind = icon
			item.menu = ""

			return item
		end,
	},
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
	comparators = {
		lspkind_comparator({
			kind_priority = {
				Parameter = 14,
				Variable = 12,
				Field = 11,
				Property = 11,
				Constant = 10,
				Enum = 10,
				EnumMember = 10,
				Event = 10,
				Function = 10,
				Method = 10,
				Operator = 10,
				Reference = 10,
				Struct = 10,
				File = 8,
				Folder = 8,
				Class = 5,
				Color = 5,
				Module = 5,
				Keyword = 2,
				Constructor = 1,
				Interface = 1,
				Snippet = 0,
				Text = 1,
				TypeParameter = 1,
				Unit = 1,
				Value = 1,
			},
		}),
		label_comparator,
	},
	window = {
		completion = cmp.config.window.bordered({
			border = "rounded",
			side_padding = 0,
			winhighlight = "Normal:CmpNormal,CursorLine:CmpSel,Search:None",
		}),

		documentation = cmp.config.window.bordered({
			border = "rounded",
			winhighlight = "Normal:Normal",
			side_padding = 5,
		}),
	},
	experimental = {
		ghost_text = {
			hl_group = "CmpGhostText",
		},
	},
	view = {
		docs = {
			auto_open = true,
		},
	},
	mapping = {
		["<C-p>"] = cmp.mapping.select_prev_item(),
		["<C-n>"] = cmp.mapping.select_next_item(),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),

		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Insert,
			select = true,
		}),

		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif require("luasnip").expand_or_jumpable() then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),

		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			elseif require("luasnip").jumpable(-1) then
				vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
			else
				fallback()
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
		{ name = "buffer" },
		{ name = "nvim_lua" },
		{ name = "path" },
	},
	performance = {
		max_view_entries = 10,
	},
})
