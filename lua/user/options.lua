local options = {
  clipboard = "unnamedplus",                                             -- allows neovim to access the system clipboard
  completeopt = { "menuone", "noselect" },                               -- mostly just for cmp
  fileencoding = "utf-8",                                                -- the encoding written to a file
  ignorecase = true,                                                     -- ignore case in search patterns
  mouse = "a",                                                           -- allow the mouse to be used in neovim
  pumheight = 10,                                                        -- pop up menu height
  showmode = false,                                                      -- we don't need to see things like -- INSERT -- anymore
  showtabline = 2,                                                       -- always show tabs
  smartcase = true,                                                      -- smart case
  smartindent = true,                                                    -- make indenting smarter again
  splitbelow = true,                                                     -- force all horizontal splits to go below current window
  splitright = true,                                                     -- force all vertical splits to go to the right of current window
  swapfile = false,                                                      -- creates a swapfile
  termguicolors = true,                                                  -- set term gui colors (most terminals support this)
  timeoutlen = 100,                                                      -- time to wait for a mapped sequence to complete (in milliseconds)
  undofile = not is_large_file,                                          -- enable persistent undo
  updatetime = 300,                                                      -- faster completion (4000ms default)
  writebackup = false,                                                   -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
  expandtab = true,                                                      -- enable convert tabs to spaces
  shiftwidth = 2,                                                        -- the number of spaces inserted for each indentation
  tabstop = 2,                                                           -- specify character width for a tab
  softtabstop = 2,                                                       -- insert 2 spaces for a tab
  cursorline = true,                                                     -- highlight the current line
  number = true,                                                         -- set numbered lines
  numberwidth = 2,                                                       -- set number column width to 2 {default 4}
  signcolumn = "yes",                                                    -- always show the sign column, otherwise it would shift the text each time
  wrap = false,                                                          -- display lines as one long line
  linebreak = true,                                                      -- wrap by word
  scrolloff = 999999,                                                     -- is one of my fav
  sidescrolloff = 8,                                                     -- scroll left to right
  inccommand = "split",                                                  -- show preview in split window when in %s mode to replace something
  lazyredraw = true,                                                     -- don't redraw while executing macros (good performance config)
  redrawtime = 7000,                                                     -- redraw timeout, otherwise to set syntax off
  title = true,                                                          -- show title
  ch = 0,                                                                -- automatically hide and show command line
  spell = false,                                                         -- enable builtin spell check that work with treesitter, so it can do well in comment spell checking
  laststatus = 3,                                                        -- enable global status line
  foldmethod = not is_large_file and "expr" or "manual",                 -- gives the fold level from foldexpr for a line
  foldexpr = not is_large_file and "nvim_treesitter#foldexpr()" or "0", -- enable treesitter experimental fold level,
  foldlevel = 99,                                                        -- dont open fold at starting up
  foldnestmax = 7,                                                       -- fold nest dont more than 2, default limit is 20
}

vim.opt.shortmess:append "c"

for k, v in pairs(options) do
  vim.opt[k] = v
end

local netrw = {
  loaded = true,
  loaded_netrwPlugin = true,
}

for k, v in pairs(netrw) do
  vim.g[k] = v
end

vim.cmd [[
  set whichwrap+=<,>,[,],h,l
  set iskeyword+=-
  set formatoptions-=cro
]]
