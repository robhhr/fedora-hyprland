-------------
-- Aliases --
-------------

local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.opt

-------------
-- Options --
-------------

o.completeopt = 'menuone,noinsert,noselect'

-----------------------
-- Plugins & Manager --
-----------------------

require "paq" {
    "savq/paq-nvim";
    "neovim/nvim-lspconfig";
    "hrsh7th/nvim-compe";
    "ms-jpq/chadtree"
}

-- Auto install and clean plugins

require('paq-nvim').install()
require('paq-nvim').clean()

----------
-- Maps --
----------

-- leader key
g.mapleader = ','
g.maplocalleader = ','

-- tree
map('', '<leader><Tab>', ':CHADopen<CR>', {noremap = true})
