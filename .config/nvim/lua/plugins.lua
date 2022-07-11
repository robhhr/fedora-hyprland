local settings = require('user-conf')
local fn = vim.fn

-- call plugin configs (to change)
require('config/nvim-autopairs')
require('config/nvim-tree')
require('config/bufferline')
require('config/lualine')
require('config/nvim-lspconfig')
require('config/nvim-treesitter')
require('config/cmp')

-- packer location
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
	return string.format('require("config/%s")', name)
end

-- install packer from github if is not in our system
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer...")
	vim.api.nvim_command("packadd packer.nvim")
end

-- initialize and configure packer
local packer = require("packer")

-- autocommand that reloads neovim when plugins.lua changes
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

packer.init({
  -- enable profiling via :PackerCompile profile=true
	enable = true,

  -- the amount in ms that a plugins load time must be over for it to be included in the profile
	threshold = 0,

  -- limit the number of simultaneous jobs. nil means no limit. set to 20 in order to prevent PackerSync form being "stuck" -> https://github.com/wbthomason/packer.nvim/issues/746
	max_jobs = 20,

	-- Have packer use a popup window
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- plugins

packer.startup(function(use)
	-- actual plugins list
	use 'wbthomason/packer.nvim'

	use({ "windwp/nvim-autopairs", config = get_config("nvim-autopairs") })

	use 'kyazdani42/nvim-web-devicons'

	use({ "kyazdani42/nvim-tree.lua", requires = {
		'kyazdani42/nvim-web-devicons'
	}, config = get_config("nvim-tree") })

	use({ "akinsho/bufferline.nvim", requires = { 'kyazdani42/nvim-web-devicons' } })
	
	use 'moll/vim-bbye'

	use({ "nvim-lualine/lualine.nvim", requires = { 'kyazdani42/nvim-web-devicons' } })

	use 'ibhagwan/fzf-lua'
	
	-- colorschemes
	use 'tiagovla/tokyodark.nvim'
	use 'shaeinst/roshnivim-cs'
	use 'glepnir/zephyr-nvim'
	use 'shaunsingh/nord.nvim'
	use 'junegunn/fzf'

	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate", config = get_config('nvim-treesitter') }) 

	-- lsp
	use({ "neovim/nvim-lspconfig", requires = {
		"williamboman/nvim-lsp-installer",
		"onsails/lspkind-nvim", config = get_config("nvim-lspconfig")
	} })

	use 'onsails/lspkind-nvim'
	use 'williamboman/nvim-lsp-installer'

	use({ 'hrsh7th/nvim-cmp', requires = {
		'onsails/lspkind-nvim',
		'hrsh7th/cmp-nvim-lsp',
		'saadparwaiz1/cmp_luasnip',
		'l3mon4d3/luasnip'
		},
		config = get_config('config')
	})

	use 'hrsh7th/cmp-nvim-lsp'
	use 'saadparwaiz1/cmp_luasnip'
	use 'l3mon4d3/luasnip'

	use({'norcalli/nvim-colorizer.lua', cmd = 'ColorizerToggle', config = function()
		require('colorizer').setup()	
	end})

end)

if PACKER_BOOTSTRAP then
	require('packer').sync()
end
