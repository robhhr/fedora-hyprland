local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- remap space as leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- normal
-- -- open netrw
keymap("n", "<leader><tab>", ":Vex<CR>", opts)
-- -- switch old/current file
keymap("n", "<S-Tab>", "<C-6>", opts)
-- -- fuzzy finder
keymap("n", "<C-p>", ":FZF<CR>", opts)
-- -- fuzzy finder 
keymap("n", "<C-g>", ":FzfLua git_files<CR>", opts)
