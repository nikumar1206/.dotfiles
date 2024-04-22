-- require("lint").linters.tflint = {
-- 	cmd = "tflint",
-- 	stdin = false, -- or false if it doesn't support content input via stdin. In that case the filename is automatically added to the arguments.
-- 	append_fname = true, -- Automatically append the file name to `args` if `stdin = false` (default: true)
-- 	args = { "-f", "json" }, -- list of arguments. Can contain functions with zero arguments that will be evaluated once the linter is used.
-- 	stream = nil, -- ('stdout' | 'stderr' | 'both') configure the stream to which the linter outputs the linting result.
-- 	ignore_exitcode = false, -- set this to true if the linter exits with a code != 0 and that's considered normal.
-- 	env = nil, -- custom environment table to use with the external process. Note that this replaces the *entire* environment, it is not additive.
-- }
--
local pylint = require("lint").linters.pylint
pylint.args = {
	"-f",
	"json",
	"--rcfile",
	os.getenv("PYLINTRC"),
}

require("lint").linters_by_ft = {
	javascript = { "eslint" },
	typescript = { "eslint" },
	python = { "pylint" },
}

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPre" }, {
	callback = function()
		require("lint").try_lint()
	end,
})
