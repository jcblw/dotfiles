set nocompatible                  " be iMproved

syntax enable                     " Turn on syntax highlighting.

set title                         " Set the terminal's title

set ignorecase                    " Case-insensitive searching.
set smartcase                     " But case-sensitive if expression contains a capital letter.

set number                        " Show line numbers.
set ruler                         " Show cursor position.

set visualbell                    " No beeping.

syntax on                      	  " https://github.com/gmarik/vundle/issues/210
filetype off                      " required!

" tab width  soft
:set expandtab
:set tabstop=2
:set shiftwidth=2
" Mouse to resize windows
:set mouse=a
" No word wrap
:set textwidth=0
:set wrapmargin=0
:set nowrap

" Setting highlight on char over 80 column width
highlight ColorColumn ctermbg=6
execute "set colorcolumn=" . join(range(81,335), ',')
highlight OverLength ctermfg=white
match OverLength /\%81v.\+/

" Vexplorer ~ NERddDtree replacement
"=================================
" Toggle Vexplore with Ctrl-E
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
      let expl_win_num = bufwinnr(t:expl_buf_num)
      if expl_win_num != -1
          let cur_win_nr = winnr()
          exec expl_win_num . 'wincmd w'
          close
          exec cur_win_nr . 'wincmd w'
          unlet t:expl_buf_num
      else
          unlet t:expl_buf_num
      endif
  else
      exec '1wincmd w'
      Vexplore
      let t:expl_buf_num = bufnr("%")
  endif
endfunction
map <silent> <C-E> :call ToggleVExplorer()<CR>

" NumberToggle ~ this will toggle the numbers in the gutter 
" =========================================================
" to relative or absolute numbers
" Toggle with Ctrl-n
" defaults relative
set relativenumber
function! NumberToggle()
    if(&relativenumber == 1)
        set number
    else
        set relativenumber
    endif
endfunc
nnoremap <C-n> :call NumberToggle()<cr>

" Hit enter in the file browser to open the selected
" file with :vsplit to the right of the browser.
let g:netrw_browse_split = 4
let g:netrw_altv = 1

" Tree Mode
let g:netrw_liststyle=3

" Change directory to the current buffer when opening files.
set autochdir

" Vundler ~ Package Manager
" ================================
" set the runtime path to include Vundle and initialize
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Vundle managing Vundle
Plugin 'gmarik/vundle.vim'
" Git Stuff
Plugin 'tpope/vim-fugitive'
" Moving around file
Plugin 'Lokaltog/vim-easymotion'
" Moving around project
Plugin 'kien/ctrlp.vim'
" Handlebars plugin
Plugin 'mustache/vim-mustache-handlebars'
" EditorConfig
Plugin 'editorconfig/editorconfig-vim'
" Less CSS
Bundle 'groenewege/vim-less'

call vundle#end()
filetype plugin indent on

" clears whitespace on save
:autocmd BufWritePost * silent! %s/\s\+$//

