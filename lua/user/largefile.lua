local autopairs_status_ok, npairs = pcall(require, "nvim-autopairs")
local null_ls_status_ok, null_ls = pcall(require, "null-ls")

local options = {
  undofile = true,
  foldmethod = "expr",
  foldexpr = "nvim_treesitter#foldexpr()",
}

local options_for_large_file = {
  undofile = false,
  foldmethod = "manual",
  foldexpr = "0",
}

_G.max_file_length = 50000

function _IS_LARGE_FILE(bufnr)
  return vim.api.nvim_buf_line_count(bufnr) > max_file_length
end

local filetype_exclude = {
  "NvimTree",
  "alpha",
  "Outline",
  "dashboard",
  "qf",
  "help",
  "man",
  "lspinfo",
  "gitcommit",
  "TelescopePrompt",
  "spectre_panel",
  "startify",
  "packer",
  "neogitstatus",
  "Trouble",
  "",
  nil,
}

function _CHECK_LARGE_FILE()
  local filetype = vim.bo.filetype

  if contains(filetype_exclude, filetype) or not filetype then
    return false
  end

  if _IS_LARGE_FILE(0) then
    for k, v in pairs(options_for_large_file) do
      vim.opt[k] = v
    end

    vim.api.nvim_exec("IndentBlanklineDisable", false)
    vim.api.nvim_exec("ColorizerToggle", false)

    if autopairs_status_ok then
      npairs.disable()
    end

    if null_ls_status_ok then
      null_ls.disable({ "eslint" })
    end
  else
    for k, v in pairs(options) do
      vim.opt[k] = v
    end

    vim.api.nvim_exec("IndentBlanklineEnable", false)
    vim.api.nvim_exec("ColorizerToggle", false)

    if autopairs_status_ok then
      npairs.enable()
    end

    if null_ls_status_ok then
      null_ls.enable({ "eslint" })
    end
  end
end
