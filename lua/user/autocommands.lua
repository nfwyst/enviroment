vim.cmd([[
  augroup _general_settings
    autocmd!
    autocmd FileType qf,help,man,lspinfo nnoremap <silent> <buffer> q :close<CR>
    autocmd TextYankPost * silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})
    autocmd BufWinEnter * silent!set formatoptions-=cro
    autocmd FileType qf set nobuflisted
  augroup end

  augroup _git
    autocmd!
    autocmd FileType gitcommit setlocal wrap
    autocmd FileType gitcommit setlocal spell
  augroup end

  augroup _markdown
    autocmd!
    autocmd FileType markdown setlocal wrap
    autocmd FileType markdown setlocal spell
  augroup end

  augroup _auto_resize
    autocmd!
    autocmd VimResized * tabdo wincmd =
  augroup end

  augroup _alpha
    autocmd!
    autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
  augroup end

  augroup _tsfold
    autocmd!
    autocmd BufWinEnter * silent!normal zx
  augroup end

  augroup _outlines
    autocmd!
    autocmd FileType Outline set nospell
  augroup end

  if executable("node")
    augroup _coderun
      autocmd!
      autocmd bufread,bufnewfile *.js noremap <leader>r :% w !node<enter>
    augroup end
  else
    augroup _coderun
      autocmd!
      autocmd bufread,bufnewfile *.js noremap <leader>r :echo "node is not installed"
    augroup end
  endif

  augroup _last_position
    autocmd!
    autocmd BufWinEnter * silent!normal '"
  augroup end

  function! _remove_trailing_whitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
  endfun
  augroup _remove_whitespace
    autocmd!
    autocmd BufWritePre * :call _remove_trailing_whitespaces()
  augroup end

  augroup _large_file
    autocmd!
    autocmd BufReadPre * silent!lua _CHECK_LARGE_FILE()
  augroup end
]])
