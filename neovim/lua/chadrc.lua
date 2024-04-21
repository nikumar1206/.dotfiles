---@type ChadrcConfig
local M = {}

-- Path to overriding theme and highlights files
local highlights = require("highlights")
M.ui = {
	lsp_semantic_tokens = true,
	extended_integrations = { "trouble" },
	theme = "nano-light",
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
		theme = "vscode_colored", -- default/vscode/vscode_colored/minimal
		separator_style = "default",
		order = nil,
		modules = nil,
	},
	cmp = {
		icons = true,
		lspkind_text = true,
		style = "flat_dark", -- default/flat_light/flat_dark/atom/atom_colored
	},
	lsp = { signature = true },
}

M.plugins = "plugins"

-- check core.mappings for table structure
M.mappings = require("mappings")

return M
