-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
	Comment = {
		italic = false,
	},
	NvDashAscii = {
		bg = "none",
		fg = "pink",
	},
	NvDashButtons = {
		bg = "none",
	},
	DiffAdd = {
		bg = "#D4EDDA",
		fg = "white",
	},
	DiffChange = {
		-- bg = "#D0E6F5",
	},
	DiffDelete = {
		bg = "#F8D7DA",
	},
}

---@type HLTable
M.add = {
	NvimTreeOpenedFolderName = { fg = "green", bold = true },
	LspInlayHint = {
		bg = "black2",
		fg = { "light_grey", 10 },
	},
}

return M
