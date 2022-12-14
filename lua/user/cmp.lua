local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
	return
end

local snip_status_ok, luasnip = pcall(require, "luasnip")
if not snip_status_ok then
	return
end

local tabnine_compare_status_ok, tabnine_compare = pcall(require, "cmp_tabnine.compare")
local copilot_compare_status_ok, copilot_compare = pcall(require, "copilot_cmp.comparators")
local compare = cmp.config.compare
local sorting = {
	priority_weight = 2,
	comparators = {
		compare.offset,
		compare.exact,
		compare.score,
		compare.recently_used,
		compare.kind,
		compare.sort_text,
		compare.length,
		compare.order,
	},
}
if tabnine_compare_status_ok then
	table.insert(sorting.comparators, 1, tabnine_compare)
end
if copilot_compare_status_ok then
	table.insert(sorting.comparators, 1, copilot_compare.score)
	table.insert(sorting.comparators, 1, copilot_compare.prioritize)
end

local from_vscode = require("luasnip/loaders/from_vscode")
from_vscode.lazy_load()

local fn = vim.fn
local snippets_path = fn.stdpath("data") .. "/custom-snippets"
if fn.empty(fn.glob(snippets_path)) <= 0 then
	from_vscode.lazy_load({ paths = { [1] = snippets_path } }) -- Load snippets from snippets_path
end

local check_backspace = function()
	local col = fn.col(".") - 1
	return col == 0 or fn.getline("."):sub(col, col):match("%s")
end

--   פּ ﯟ   some other good icons
local kind_icons = {
	Text = "",
	Method = "m",
	Function = "",
	Constructor = "",
	Field = "",
	Variable = "",
	Class = "",
	Interface = "",
	Module = "",
	Property = "",
	Unit = "",
	Value = "",
	Enum = "",
	Keyword = "",
	Snippet = "",
	Color = "",
	File = "",
	Reference = "",
	Folder = "",
	EnumMember = "",
	Constant = "",
	Struct = "",
	Event = "ﳅ",
	Operator = "",
	TypeParameter = "",
	Copilot = "",
}
-- find more here: https://www.nerdfonts.com/cheat-sheet

local filetype_exclude = {
	"TelescopePrompt",
}

local source_mapping = {
	luasnip = "[Snippet]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[NvimLua]",
	cmp_tabnine = "[Tn]",
	buffer = "[Buffer]",
	path = "[Path]",
	copilot = "[C]",
}

local border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" }

local has_words_before = function()
	if vim.api.nvim_buf_get_option(0, "buftype") == "prompt" then
		return false
	end
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_text(0, line - 1, 0, line - 1, col, {})[1]:match("^%s*$") == nil
end

cmp.setup({
	enabled = function()
		return not _IS_LARGE_FILE(0) and not contains(filetype_exclude, vim.bo.filetype)
	end,
	snippet = {
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	mapping = {
		["<C-k>"] = cmp.mapping.select_prev_item(),
		["<C-j>"] = cmp.mapping.select_next_item(),
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
		["<C-l>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		-- Accept currently selected item. If none selected, `select` first item.
		-- Set `select` to `false` to only confirm explicitly selected items.
		["<CR>"] = cmp.mapping.confirm({
			select = true,
			behavior = cmp.ConfirmBehavior.Replace,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.jumpable(1) then
				luasnip.jump(1)
			elseif check_backspace() then
				fallback()
			else
				fallback()
			end
		end, { "s", "i" }),
		["<S-Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() and has_words_before() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "s", "i" }),
	},
	formatting = {
		fields = { "abbr", "kind", "menu" },
		format = function(entry, vim_item)
			vim_item.menu = source_mapping[entry.source.name]
			vim_item.kind = string.format("%s", kind_icons[vim_item.kind])

			if entry.source.name == "cmp_tabnine" then
				local data = entry.completion_item.data or {}
				vim_item.kind = ""
				if data.multiline then
					vim_item.kind = vim_item.kind .. " " .. "[ML]"
				end
			end

			return vim_item
		end,
	},
	sources = {
		{ name = "copilot", max_item_count = 7 },
		{ name = "luasnip", max_item_count = 7 },
		{ name = "nvim_lsp", max_item_count = 7 },
		{ name = "nvim_lua", max_item_count = 7 },
		{ name = "cmp_tabnine" },
		{ name = "buffer", max_item_count = 7 },
		{ name = "path", max_item_count = 7 },
	},
	confirm_opts = {
		behavior = cmp.ConfirmBehavior.Replace,
		select = false,
	},
	window = {
		completion = {
			border = border,
			side_padding = 0,
			col_offset = 1,
			scrollbar = false,
		},
		documentation = {
			border = border,
		},
	},
	experimental = {
		ghost_text = false,
		native_menu = false,
	},
	sorting = sorting,
})
