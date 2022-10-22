local path = vim.fn.expand("%")
local file_size = vim.fn.getfsize(path)
local line_count = vim.fn.line("$")

_G.is_large_file = line_count > 50000 or file_size > 5242880

function _CHECK_LARGE_FILE()
  if is_large_file then
    vim.cmd("IndentBlanklineDisable")
  end
end
