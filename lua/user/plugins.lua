local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
local packer_user_config = vim.api.nvim_create_augroup("packer_user_config", { clear = true })
vim.api.nvim_create_autocmd(
	"BufWritePost",
	{ pattern = "plugins.lua", command = "source <afile> | PackerSync", group = packer_user_config }
)

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
	return
end

-- Have packer use a popup window
packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

-- Install your plugins here
return packer.startup(function(use)
	use("wbthomason/packer.nvim") -- Have packer manage itself
	use("nvim-lua/plenary.nvim") -- Useful lua functions used by lots of plugins
	use("windwp/nvim-autopairs") -- Autopairs, integrates with both cmp and treesitter
	use("numToStr/Comment.nvim")
	use("JoosepAlviste/nvim-ts-context-commentstring")
	use("kyazdani42/nvim-web-devicons")
	use("kyazdani42/nvim-tree.lua")
	use("akinsho/bufferline.nvim")
	use("famiu/bufdelete.nvim")
	use("nvim-lualine/lualine.nvim")
	use("akinsho/toggleterm.nvim")
	use("ahmedkhalf/project.nvim")
	use("lewis6991/impatient.nvim")
	use("lukas-reineke/indent-blankline.nvim")
	use("goolord/alpha-nvim")
	use("folke/which-key.nvim")

	-- Colorschemes
	use("folke/tokyonight.nvim")
	use("Tsuzat/NeoSolarized.nvim")
	use("shaunsingh/solarized.nvim")

	-- cmp plugins
	use("hrsh7th/nvim-cmp") -- The completion plugin
	use("hrsh7th/cmp-buffer") -- buffer completions
	use("hrsh7th/cmp-path") -- path completions
	use("saadparwaiz1/cmp_luasnip") -- snippet completions
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")

	-- snippets
	use("L3MON4D3/LuaSnip") --snippet engine
	use("rafamadriz/friendly-snippets") -- a bunch of snippets to use

	-- LSP
	use("neovim/nvim-lspconfig") -- enable LSP
	use("williamboman/mason.nvim")
	use("williamboman/mason-lspconfig.nvim")
	use("jose-elias-alvarez/null-ls.nvim") -- for formatters and linters
	use("RRethy/vim-illuminate") -- automatically highlighting other uses of the word under the cursor using lsp
	use("simrat39/symbols-outline.nvim") -- enable outline based on lsp

	-- Telescope
	use("nvim-telescope/telescope.nvim")

	-- Treesitter
	-- Run :TSUpdate to work
	use("nvim-treesitter/nvim-treesitter")

	-- Treesitter Playground
	-- Run :TSInstall query to work
	use({ "nvim-treesitter/playground", requires = { "nvim-treesitter/nvim-treesitter" } })

	-- Treesitter Better Syntax Highlighting
	-- use({ "David-Kunz/markid", requires = { "nvim-treesitter/nvim-treesitter" } })

	-- Git
	use("lewis6991/gitsigns.nvim")

	-- Debug
	use("mfussenegger/nvim-dap")
	use({ "mxsdev/nvim-dap-vscode-js", requires = { "mfussenegger/nvim-dap" } })
	use({
		"microsoft/vscode-js-debug",
		opt = true,
		run = "npm install --legacy-peer-deps && npm run compile && git restore .",
	})
	use({
		"nvim-telescope/telescope-dap.nvim",
		requires = { "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" },
	})
	use({ "theHamsta/nvim-dap-virtual-text", requires = { "mfussenegger/nvim-dap", "nvim-treesitter/nvim-treesitter" } })
	use({ "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap" } })

	-- Color highlighter
	use("norcalli/nvim-colorizer.lua")

	-- copilot
	use({
		"zbirenbaum/copilot.lua",
		event = "VimEnter",
		config = function()
			require("user.defer.copilot")
		end,
	})

	-- docs
	use({
		"danymat/neogen",
		event = "VimEnter",
		config = function()
			require("user.defer.neogen")
		end,
		requires = { "nvim-treesitter/nvim-treesitter", "L3MON4D3/LuaSnip" },
	})

	-- emmet
	use("mattn/emmet-vim")

	-- Automatically set up your configuration after cloning packer.nvim
	-- Put this at the end after all plugins
	if PACKER_BOOTSTRAP then
		require("packer").sync()
	end
end)
