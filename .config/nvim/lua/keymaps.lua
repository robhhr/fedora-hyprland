-- local map = vim.keymap.set
local map = vim.api.nvim_set_keymap
local default_options = { noremap = true, silent = true }
local expr_options = { expr = true, silent = true }

-- remap leader key
-- map({"n", "v"}, ",", "<Nop>", { silent = true })
map("n", "<Space>", "<Nop>", default_options)
vim.g.mapleader = " "
-- vim.g.maplocalleader = " "
