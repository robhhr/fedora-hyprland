-------------
-- Aliases --
-------------

local cmd = vim.cmd
local fn = vim.fn
local g = vim.g
local map = vim.api.nvim_set_keymap
local o = vim.opt

-------------
-- Options --
-------------

o.completeopt = 'menuone,noinsert,noselect'
o.shiftwidth = 2

-----------------------
-- Plugins & Manager --
-----------------------

-- Auto install plugin manager

local install_path = fn.stdpath('data')..'/site/pack/paqs/opt/paq-nvim'

if fn.empty(fn.glob(install_path)) > 0 then
    cmd('!git clone --depth 1 https://github.com/savq/paq-nvim.git '..install_path)
end

cmd 'packadd paq-nvim'
local plug = require('paq-nvim').paq

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
