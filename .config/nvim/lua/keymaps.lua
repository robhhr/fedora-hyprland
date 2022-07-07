local opts = { noremap = true, silent = true }
local term_opts = { silent = true }
local keymap = vim.api.nvim_set_keymap

-- remap space as leader
keymap("", "<Space>", "<Nop>", opts)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- normal
-- -- save
keymap("n", "<leader>w", ":w<CR>", opts)
-- -- save & quit
keymap("n", "<leader>wq", ":wq<CR>", opts)
-- -- quit
keymap("n", "<leader>q", ":q!<CR>", opts)

-- -- plugins
-- -- -- open tree
keymap("n", "<leader><tab>", ":NvimTreeToggle<CR>", opts)
-- -- -- switch old/current file
keymap("n", "<S-Tab>", "<C-6>", opts)
-- -- -- fuzzy finder
keymap("n", "<C-p>", ":FZF<CR>", opts)
-- -- -- fuzzy finder 
keymap("n", "<C-g>", ":FzfLua git_files<CR>", opts)
-- -- -- close buffer tab
keymap("n", "<leader>W", ":Bwipeout<CR>", opts)
-- -- -- toggle next buffer
keymap("n", "<leader><Right>", ":BufferLineCycleNext<CR>", opts)
-- -- -- toggle prev buffer
keymap("n", "<leader><Left>", ":BufferLineCyclePrev<CR>", opts)
