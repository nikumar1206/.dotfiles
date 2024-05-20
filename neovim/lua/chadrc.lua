---@type ChadrcConfig
local M = {}

local sep_style = "block"

local default_sep_icons = {
	round = { left = "", right = "" },
	block = { left = "█", right = "█" },
}
local separators = (type(sep_style) == "table" and sep_style) or default_sep_icons[sep_style]

local sep_l = separators["left"]
local sep_r = "%#St_sep_r#" .. separators["right"] .. " %#ST_EmptySpace#"
local function gen_block(icon, txt, sep_l_hlgroup, iconHl_group, txt_hl_group)
	return sep_l_hlgroup .. sep_l .. iconHl_group .. icon .. " " .. txt_hl_group .. " " .. txt .. sep_r
end

-- Path to overriding theme and highlights files
local highlights = require("highlights")
M.ui = {
	lsp_semantic_tokens = true,
	extended_integrations = { "trouble" },
	theme = "everforest",
	nvdash = {
		load_on_startup = true,
		header = { " /\\_/\\ ", "( o.o )", " > ^ < " },
		buttons = {},
	},
	hl_override = highlights.override,
	hl_add = highlights.add,
	status = {
		colorizer = true,
		dashboard = true,
		telescope_media = true,
	},
	statusline = {
		theme = "minimal", -- default/vscode/vscode_colored/minimal
		separator_style = "default",
		order = nil,
		modules = {
			lsp = function()
				-- local devicons_present, devicons = pcall(require, "nvim-web-devicons")
				M.stbufnr = function()
					return vim.api.nvim_win_get_buf(vim.g.statusline_winid or 0)
				end

				if rawget(vim, "lsp") then
					for _, client in ipairs(vim.lsp.get_active_clients()) do
						if client.attached_buffers[M.stbufnr()] then
							return gen_block("󰿘", client.name, "%#St_Lsp_sep#", "%#St_Lsp_bg#", "%#St_Lsp_txt#")
						end
					end
				end
			end,
			cursor = function()
				return ""
			end,
		},
	},
	cmp = {
		icons = true,
		lspkind_text = true,
		style = "atom_colored", -- default/flat_light/flat_dark/atom/atom_colored
	},
	lsp = { signature = false },
}

M.plugins = "plugins"

-- check core.mappings for table structure
M.mappings = require("mappings")

return M
