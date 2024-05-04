vim.g.base46_cache = vim.fn.stdpath("data") .. "/nvchad/base46/"
vim.g.mapleader = " "
vim.g.rainbow_active = 1
vim.o.inccommand = "split"
vim.o.termguicolors = true
vim.o.showcmd = false

local autocmd = vim.api.nvim_create_autocmd

-- set relative line numbers
vim.cmd([[
  augroup nvim_lsp
    autocmd!
    autocmd BufRead,BufNewFile * setlocal relativenumber
  augroup END
]])

-- set up tf file support
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tf]])
vim.cmd([[silent! autocmd! filetypedetect BufRead,BufNewFile *.tfvars]])
vim.cmd([[autocmd BufRead,BufNewFile *.hcl,.terraformrc,terraform.rc set filetype=hcl]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfvars set filetype=terraform-vars]])
vim.cmd([[autocmd BufRead,BufNewFile *.tfstate,*.tfstate.backup set filetype=json]])

local function has_venv()
	local current_dir = vim.fn.getcwd()
	local venv_dir = current_dir .. "/.venv"
	return vim.fn.isdirectory(venv_dir) == 1
end

if has_venv() then
	vim.g.python3_host_prog = vim.fn.expand("%:p:h") .. "/.venv/bin/python"
end

local enable_providers = { "python3_provider", "node_provider" }
for _, plugin in pairs(enable_providers) do
	vim.g["loaded_" .. plugin] = nil
	vim.cmd("runtime " .. plugin)
end

autocmd("FileType", {
	callback = function()
		if vim.bo.ft == "nvdash" then
			vim.opt.laststatus = 0
		else
			vim.opt.laststatus = 3
		end
	end,
})
if vim.g.neovide then
	vim.g.neovide_floating_z_height = 0
	vim.o.guifont = "JetBrainsMonoNL Nerd Font Mono:h15"
	vim.g.neovide_hide_mouse_when_typing = true
	vim.g.neovide_fullscreen = true
	vim.g.neovide_cursor_trail_size = 0.1
	vim.g.neovide_cursor_animation_length = 0.1
	vim.g.neovide_font_hinting = "none"
	vim.g.neovide_font_edging = "subpixelantialias"
	vim.g.neovide_floating_shadow = false
	vim.g.neovide_refresh_rate = 144
end
-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	local repo = "https://github.com/folke/lazy.nvim.git"
	vim.fn.system({ "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath })
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require("configs.lazy")

-- load plugins
require("lazy").setup({
	{
		"NvChad/NvChad",
		lazy = false,
		branch = "v2.5",
		import = "nvchad.plugins",
		config = function()
			require("options")
		end,
	},
	{
		import = "plugins",
	},
}, lazy_config)

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require("nvchad.autocmds")

vim.schedule(function()
	require("mappings")
end)
