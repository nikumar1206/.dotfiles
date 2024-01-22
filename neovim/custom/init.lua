local autocmd = vim.api.nvim_create_autocmd
-- Auto resize panes when resizing nvim window
-- autocmd("VimResized", {
--   pattern = "*",
--   command = "tabdo wincmd =",
-- })
vim.cmd([[
  augroup nvim_lsp
    autocmd!
    autocmd BufRead,BufNewFile * setlocal relativenumber
    " autocmd BufRead,BufNewFile * setlocal nolist
    " autocmd BufRead,BufNewFile * setlocal foldmethod=manual
    " autocmd BufRead,BufNewFile * setlocal cursorline
  augroup END
]])


local function has_venv()
  local current_dir = vim.fn.getcwd()
  local venv_dir = current_dir .. '/.venv'
  return vim.fn.isdirectory(venv_dir) == 1
end

if has_venv() then
  vim.g.python3_host_prog = vim.fn.expand('%:p:h') .. '/.venv/bin/python'
end

local enable_providers = {
  "python3_provider",
  "node_provider"
}
for _, plugin in pairs(enable_providers) do
  vim.g["loaded_" .. plugin] = nil
  vim.cmd("runtime " .. plugin)
end

-- Disable arrow keys

vim.api.nvim_set_keymap('n', ',', '<<', { noremap = true, silent = true })

-- Map period to indent in normal mode
vim.api.nvim_set_keymap('n', '.', '>>', { noremap = true, silent = true })

-- Map comma to outdent in visual mode
vim.api.nvim_set_keymap('x', ',', '<', { noremap = true, silent = true })

-- Map period to indent in visual mode
vim.api.nvim_set_keymap('x', '.', '>', { noremap = true, silent = true })

local opts = {}
vim.api.nvim_set_keymap("v", "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>", opts)
vim.api.nvim_set_keymap("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>", opts)
vim.api.nvim_set_keymap("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>", opts)

vim.api.nvim_set_keymap("n", "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rbW", "<CMD>SearchReplaceMultiBufferCWORD<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>", opts)

-- show the effects of a search / replace in a live preview window
vim.o.inccommand = "split"

autocmd("FileType", {
  callback = function()
    if vim.bo.ft == "nvdash" then
      vim.opt.laststatus=0
    else
      vim.opt.laststatus=3
    end
  end
})
vim.o.scrolloff = 5
if vim.g.neovide then
  vim.o.guifont = "JetBrainsMono Nerd Font Propo:h13"
  vim.g.neovide_hide_mouse_when_typing = true
  vim.g.neovide_fullscreen = true
  vim.g.neovide_cursor_trail_size = 0.4
  vim.g.neovide_font_hinting = 'none'
  vim.g.neovide_font_edging = 'subpixelantialias'
  vim.g.neovide_refresh_rate = 144
  vim.g.neovide_floating_shadow = false
  vim.keymap.set("x", "<D-x>", '"+dm0i<Esc>`0')                                   -- cut (include insert hack to fix whichkey issue #518)
  vim.keymap.set("x", "<D-c>", '"+y')                                             -- copy
  vim.keymap.set("i", "<D-v>", "<C-r><C-o>+")                                     -- paste (insert)
  vim.keymap.set("n", "<D-v>", "i<C-r><C-o>+<Esc>l")                              -- paste (normal)
  vim.keymap.set("x", "<D-v>", '"+P')                                             -- paste (visual)
  vim.keymap.set("c", "<D-v>", "<C-r>+")                                          -- paste (command)
  vim.cmd [[
" system clipboard
    nmap <c-c> "+y
    vmap <c-c> "+y
    nmap <c-v> "+p
    inoremap <c-v> <c-r>+
    cnoremap <c-v> <c-r>+
    " use <c-r> to insert original character without triggering things like auto-pairs
    inoremap <c-r> <c-v>
  ]]
end
