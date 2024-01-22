---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}
M.gopher = {
  plugin = true,
  n = {
    ["<leader>gj"] = {
      "<cmd> GoTagAdd json <CR>",
      "Add json struct tags"
    },
    ["<leader>gy"] = {
      "<cmd> GoTagAdd yaml <CR>",
      "Add yaml struct tags"
    },
    ["<leader>ge"] = {
      "<cmd> GoIfErr <CR>",
      "Add iferr block"
    }
  }
}
-- more keybinds!

return M
