vim.g.NeoSolarized_italics = 1 -- 0 or 1
vim.g.NeoSolarized_visibility = 'normal' -- low, normal, high
vim.g.NeoSolarized_diffmode = 'normal' -- low, normal, high
vim.g.NeoSolarized_termtrans = 1 -- 0(default) or 1 -> Transparency
vim.g.NeoSolarized_lineNr = 0 -- 0 or 1 (default) -> To Show backgroung in LineNr
vim.g.Illuminate_useDeprecated = 1 -- Force old version illuminate behavior
vim.g.Illuminate_ftblacklist = { 'NvimTree', 'alpha', 'Outline' } -- The filetype that illuminate will not work

vim.cmd [[
try
  colorscheme NeoSolarized
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry

augroup BgHighlight
  autocmd!
  highlight FloatBorder guibg=NONE ctermbg=NONE  " Removes the border of float menu (LSP and Autocompletion uses it)
  highlight link NormalFloat Normal
  highlight NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
  highlight Pmenu ctermbg=NONE guibg=NONE
  highlight ColorColumn guibg=238
  highlight CursorLine gui=bold cterm=bold
  highlight IlluminatedWordText gui=bold cterm=bold guibg=#002b36
augroup END
]]

