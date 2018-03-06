set nocompatible

call plug#begin('~/.vim/plugged')
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-sleuth'
Plug 'altercation/vim-colors-solarized'
Plug 'ervandew/supertab'
Plug 'vim-syntastic/syntastic'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
call plug#end()

function! GoToTest(file)
    let split_path = split(a:file, "/")
    let test_path = "tests/phpunit"
    for part in split_path
        if part != "Etsyweb" && part != "phplib"

            let split_part = split(part, '\.')

            if len(split_part) != 1
                let part = split_part[0] . 'Test.php'
            endif

            let test_path .= "/" . part
        endif
    endfor

    :execute "vsplit " . l:test_path
endfunction

"indentation
set shiftwidth=4
set tabstop=4
set softtabstop=4
set shiftround
set expandtab
set autoindent
set smartindent
set backspace=indent,eol,start

"line numbering
set number
set relativenumber
autocmd InsertEnter,InsertLeave * :set invrelativenumber

" gf (Etsyweb/phplib files only)
set path=~/development/Etsyweb/phplib
set includeexpr=substitute(v:fname,'_','/','g')
set suffixesadd+=.php

" mappings
let mapleader=' '
inoremap jk <ESC>
nnoremap <leader>p :set invpaste<cr>    
nnoremap <leader>c :TComment<cr>
vnoremap <leader>c :TComment<cr>

" testing
nnoremap <Leader>rlt :w <bar> !run_test.sh "" nosetup "" 1 <CR>
nnoremap <Leader>rt :wa <bar> !run_test.sh % nosetup <CR>
nnoremap <Leader>rot :wa <bar> !run_test.sh % nosetup <C-R><C-W> <CR>
nnoremap <Leader>rst :wa <bar> !run_test.sh % setup<CR>
nnoremap <Leader>rsot :wa <bar> !run_test.sh % setup <C-R><C-W> <CR>
nnoremap <Leader>gt :call GoToTest(@%)<CR>

"ignore case
set ignorecase

"tabs
nnoremap <leader>tn :tabnew<CR>
nnoremap <leader>] :tabnext<CR>
nnoremap <leader>[ :tabprevious<CR>

"windows
nnoremap <C-H> <C-W><C-H>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-J> <C-W><C-J>

nnoremap <leader>sv :so ~/.vimrc<CR>
nnoremap <leader>ev :tabe ~/.vimrc<CR>
nnoremap <leader>w :wa<CR>

"fzf
set rtp+=~/.fzf

nnoremap <Leader>; :Files<CR>
nnoremap <Leader>t; :BTags<CR>
nnoremap <Leader>pt; :Tags<CR>
nnoremap <Leader>m; :History<CR>
nnoremap <Leader>l; :BLines<CR>
nnoremap <Leader>b; :Buffers<CR>
