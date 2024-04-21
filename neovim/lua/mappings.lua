require("nvchad.mappings")

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("x", ";", ":", { desc = "CMD enter command mode" })

map("n", "<leader>fm", function()
	require("conform").format()
end, { desc = "File Format with conform" })

-- easier indenting/outdenting
map("n", ",", "<<")
map("n", ".", ">>")
map("x", ",", "<")
map("x", ".", ">")

-- for copy pasting
map("n", "<leader>a", "ggVG")

-- for search and replace
map("v", "<C-r>", "<CMD>SearchReplaceSingleBufferVisualSelection<CR>")
map("v", "<C-s>", "<CMD>SearchReplaceWithinVisualSelection<CR>")
map("v", "<C-b>", "<CMD>SearchReplaceWithinVisualSelectionCWord<CR>")

map("n", "<leader>rs", "<CMD>SearchReplaceSingleBufferSelections<CR>")
map("n", "<leader>ro", "<CMD>SearchReplaceSingleBufferOpen<CR>")
map("n", "<leader>rw", "<CMD>SearchReplaceSingleBufferCWord<CR>")
map("n", "<leader>rW", "<CMD>SearchReplaceSingleBufferCWORD<CR>")
map("n", "<leader>re", "<CMD>SearchReplaceSingleBufferCExpr<CR>")
map("n", "<leader>rf", "<CMD>SearchReplaceSingleBufferCFile<CR>")

map("n", "<leader>rbs", "<CMD>SearchReplaceMultiBufferSelections<CR>")
map("n", "<leader>rbo", "<CMD>SearchReplaceMultiBufferOpen<CR>")
map("n", "<leader>rbw", "<CMD>SearchReplaceMultiBufferCWord<CR>")
map("n", "<leader>rbW", "<CMD>SearchReplaceMultiBufferCWORD<CR>")
map("n", "<leader>rbe", "<CMD>SearchReplaceMultiBufferCExpr<CR>")
map("n", "<leader>rbf", "<CMD>SearchReplaceMultiBufferCFile<CR>")

map("x", "<D-x>", '"+dm0i<Esc>`0') -- cut (include insert hack to fix whichkey issue #518)
map("x", "<D-c>", '"+y') -- copy
map("i", "<D-v>", "<C-r><C-o>+") -- paste (insert)
map("n", "<D-v>", "i<C-r><C-o>+<Esc>l") -- paste (normal)
map("x", "<D-v>", '"+P') -- paste (visual)
map("c", "<D-v>", "<C-r>+") -- paste (command)
