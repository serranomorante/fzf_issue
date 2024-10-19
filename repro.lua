-- DO NOT change the paths
local root = vim.fn.fnamemodify("./.repro", ":p")
root = root:sub(-1) == "/" and root or root .. "/"

-- set stdpaths to use .repro
for _, name in ipairs({ "config", "data", "state", "cache" }) do
	vim.env[("XDG_%s_HOME"):format(name:upper())] = root .. name
end

--------------------------------------------------------------------------------

vim.g.mapleader = " "

--------------------------------------------------------------------------------

local plugins = {
	{
		"junegunn/fzf.vim",
		dependencies = {
			{
				"junegunn/fzf",
				build = function() vim.fn["fzf#install"]() end,
			}
		},
		lazy = false
	},
}

--------------------------------------------------------------------------------

local lazypath = root .. "/plugins/lazy.nvim"
---@diagnostic disable-next-line: undefined-field
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup(plugins, {
	root = root .. "/plugins",
})
