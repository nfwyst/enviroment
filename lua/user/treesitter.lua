local status_ok, configs = pcall(require, "nvim-treesitter.configs")
local istatus_ok, install = pcall(require, "nvim-treesitter.install")
if not status_ok or not istatus_ok then
	return
end

install.prefer_git = false

configs.setup({
	ensure_installed = "all", -- one of "all" or a list of languages
	ignore_install = { "phpdoc", "org", "norg", "pascal", "c_sharp", "java", "kotlin", "php", "erlang", "elixir", "julia", "fish", "fortran", "perl", "ruby", "toml", "swift", "fusion" }, -- List of parsers to ignore installing
	highlight = {
		enable = true, -- false will disable the whole extension
		disable = { "css" }, -- list of language that will be disabled
	},
	autopairs = {
		enable = true,
	},
	markid = { enable = true },
	indent = { enable = true, disable = { "python", "css" } },
	context_commentstring = { enable = true, enable_autocmd = false },
	playground = {
		enable = true,
		disable = {},
		updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
		persist_queries = false, -- Whether the query persists across vim sessions
		keybindings = {
			toggle_query_editor = "o",
			toggle_hl_groups = "i",
			toggle_injected_languages = "t",
			toggle_anonymous_nodes = "a",
			toggle_language_display = "I",
			focus_language = "f",
			unfocus_language = "F",
			update = "R",
			goto_node = "<cr>",
			show_help = "?",
		},
	},
})
