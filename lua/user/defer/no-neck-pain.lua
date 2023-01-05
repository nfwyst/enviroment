vim.defer_fn(function()
	local no_neck_pain = require("no-neck-pain")
	no_neck_pain.setup({
		width = 86,
		buffers = {
			backgroundColor = "catppuccin-frappe",
			textColor = "#777777",
		},
		integrations = {
			NvimTree = {
				position = "right",
			},
		},
	})

	_IS_IN_NO_NECK_PAIN = false

	function _NO_NECK_PAIN_TOGGLE()
		_IS_IN_NO_NECK_PAIN = not _IS_IN_NO_NECK_PAIN
		no_neck_pain.toggle()
	end
end, 100)
