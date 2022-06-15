local fn = vim.fn

-- packer location
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"

-- install packer from github if is not in our system
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "installing packer close and reopen neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- autocommand that reloads neovim when plugins.lua changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- use a protected require call (pcall) so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- plugins

return packer.startup(function(use)
  -- have packer manage itself
  use "wbthomason/packer.nvim"
  
   -- an implementation of the popup API from vim in neovim
  use "nvim-lua/popup.nvim"

  -- colorschemes
  use "lunarvim/darkplus.nvim"

  -- tree-sitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
    require('treesitter')
  }

  -- automatically set up config after cloning packer.nvim
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)

