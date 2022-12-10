local util_status_ok, util = pcall(require, "lspconfig/util")
local status_ok, telescope = pcall(require, "telescope")
if not util_status_ok or not status_ok then
	return
end

local actions = require("telescope.actions")

_G.cwd = vim.loop.cwd()

function _G.set_global_cwd()
	_G.cwd = util.root_pattern(".git")(vim.fn.expand("%:p")) or ""
	print("cwd set to: " .. cwd)
end

function _G.set_local_cwd()
	_G.cwd = vim.loop.cwd() or ""
	print("cwd set to: " .. cwd)
end

local themes = require("telescope.themes")
local builtin = require("telescope.builtin")

telescope.setup({
	defaults = {
		prompt_prefix = " ",
		selection_caret = " ",
		path_display = { "smart" },
		preview = {
			filesize_limit = 1,
		},
		mappings = {
			i = {
				["<C-n>"] = actions.cycle_history_next,
				["<C-p>"] = actions.cycle_history_prev,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,

				["<C-c>"] = actions.close,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,

				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
				["<C-l>"] = actions.complete_tag,
				["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
			},

			n = {
				["<esc>"] = actions.close,
				["<CR>"] = actions.select_default,
				["<C-x>"] = actions.select_horizontal,
				["<C-v>"] = actions.select_vertical,
				["<C-t>"] = actions.select_tab,

				["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
				["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
				["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
				["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

				["j"] = actions.move_selection_next,
				["k"] = actions.move_selection_previous,
				["H"] = actions.move_to_top,
				["M"] = actions.move_to_middle,
				["L"] = actions.move_to_bottom,

				["<Down>"] = actions.move_selection_next,
				["<Up>"] = actions.move_selection_previous,
				["gg"] = actions.move_to_top,
				["G"] = actions.move_to_bottom,

				["<C-u>"] = actions.preview_scrolling_up,
				["<C-d>"] = actions.preview_scrolling_down,

				["<PageUp>"] = actions.results_scrolling_up,
				["<PageDown>"] = actions.results_scrolling_down,

				["?"] = actions.which_key,
			},
		},
	},
	pickers = {
		-- Default configuration for builtin pickers goes here:
		-- picker_name = {
		--   picker_config_key = value,
		--   ...
		-- }
		-- Now the picker_config_key will be applied every time you call this
		-- builtin picker
	},
	extensions = {
		-- Your extension configuration goes here:
		-- extension_name = {
		--   extension_config_key = value,
		-- }
		-- please take a look at the readme of the extension you want to configure
	},
})

pcall(telescope.load_extension, "dap")

function _FIND_FILES()
	local theme = themes.get_dropdown({ previewer = false })
	theme.cwd = cwd
	builtin.find_files(theme)
end

function _LIVE_GREP()
	local theme = themes.get_ivy()
	theme.cwd = cwd
	theme.additional_args = function()
		return {
			"--glob=!*.svg",
			"--glob=!yarn.lock",
			"--glob=!pnpm-lock.yaml",
			"--glob=!package-lock.json",
			"--glob=!dist",
			"--glob=!build",
			"--glob=!lib",
			"--glob=!temp",
			"--glob=!.umi",
			"--glob=!.cache",
			"--glob=!__snapshots__",
		}
	end

	builtin.live_grep(theme)
end
