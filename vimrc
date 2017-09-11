" =============================
" Author: raytlty
" Email: alexmao930918@gmail.com
" ==============================

let mapleader = ','
let g:mapleader = ','

set nocompatible
filetype off " required! turn off

call plug#begin('~/.vim/bundle')
Plug 'airblade/vim-gitgutter'
Plug 'altercation/vim-colors-solarized'
Plug 'docunext/closetag.vim'
Plug 'elzr/vim-json', {'for': 'json'}
Plug 'fatih/vim-go'
Plug 'Glench/Vim-Jinja2-Syntax', {'for': ['python', 'python3']}
Plug 'hdima/python-syntax', {'for': ['python', 'python3']}
Plug 'honza/vim-snippets'
Plug 'hynek/vim-python-pep8-indent', { 'for': ['python', 'python3'] }
Plug 'jiangmiao/auto-pairs'
Plug 'kshenoy/vim-signature'
Plug 'kien/rainbow_parentheses.vim'
Plug 'luochen1990/rainbow'
Plug 'Lokaltog/vim-powerline'
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown', {'for': 'md'}
Plug 'rking/ag.vim'
Plug 'Raimondi/delimitMate'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree', { 'on': 'NERDTreeToggle'  } | Plug 'jistr/vim-nerdtree-tabs'
Plug 'scrooloose/syntastic'
Plug 'tacahiroy/ctrlp-funky' | Plug 'ctrlpvim/ctrlp.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'terryma/vim-expand-region'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Valloric/YouCompleteMe',  { 'for': ['c', 'cpp', 'python', 'python3'] }
Plug 'Yggdroot/indentLine'
call plug#end()

" setting
filetype on " 检测文件类型
filetype indent on " 针对不同文件采取不同缩进
filetype plugin on " 允许插件
filetype plugin indent on " 启动插件自动补全

" default
set autoindent
set autoread
set backspace=indent,eol,start
set encoding=utf-8
" 合并两行中文时，不在中间加空格
set formatoptions+=B
set history=10000
set hlsearch
set incsearch
set laststatus=2
set magic " For regular expressions turn magic on
set novisualbell
set noerrorbells
set scrolloff=7
set shortmess=atI
set showcmd
set showmode
set smartcase
set smartindent
set wildmenu
set whichwrap+=<,>,h,l
" set t_ti=t_te= 退出后展示历史记录
" set autochdir 自动更改到当前文件的工作目录
" 相对行号: 行号变成相对，可以用 nj/nk 进行跳转
set relativenumber number
au FocusLost * :set norelativenumber number
au FocusGained * :set relativenumber
" 插入模式下用绝对行号, 普通模式下用相对
autocmd InsertEnter * :set norelativenumber number
autocmd InsertLeave * :set relativenumber
nnoremap ; :
" 回车即选中当前选项
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"
"vnoremap < <gv
"vnoremap > >gv

"syntax
syntax on
syntax enable

" display
set ignorecase
set number
set ruler
set cursorline cursorcolumn
set textwidth=0

"display pairs
" 取消换行
" set nowrap
" 自动换行
set wrap
" 括号配对情况, 跳转并高亮一下匹配的括号
set showmatch
" How many tenths of a second to blink when matching brackets
set matchtime=2

"indent
set expandtab
set shiftwidth=4
set tabstop=4
set softtabstop=4
set cindent
set shiftround
set smarttab

"" A buffer becomes hidden when it is abandoned
"set hidden
"set wildmode=list:longest
"set ttyfast
"" 增强模式中的命令行自动完成操作
"set wildignore=*.o,*~,*.pyc,*.class

" 分屏窗口移动, Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" 复制选中区到系统剪切板中
vnoremap <C-c> "+y

" http://vim.wikia.com/wiki/Alternative_tab_navigation
" "
" http://stackoverflow.com/questions/2005214/switching-to-a-particular-tab-in-vim
"
"" tab切换
map Th :tabfirst<cr>
map Tl :tablast<cr>

map Tk :tabnext<cr>
map Tj :tabprev<cr>
map Tn :tabnext<cr>
map Tp :tabprev<cr>

map Te :tabedit<cr>
map Td :tabclose<cr>
map Tm :tabm<cr>

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" => 选中及操作改键
" 调整缩进后自动选中，方便再次操作
vnoremap < <gv
vnoremap > >gv"

" 保存python文件时删除多余空格
fun! <SID>StripTrailingWhitespaces()
    let l = line(".")
    let c = col(".")
    %s/\s\+$//e
    call cursor(l, c)
endfun
autocmd FileType c,cpp,java,go,php,javascript,puppet,python,rust,twig,xml,yml,perl,html autocmd BufWritePre <buffer> :call <SID>StripTrailingWhitespaces()

" 定义函数AutoSetFileHead，自动插入文件头
autocmd BufNewFile *.sh,*.py,*.cpp exec ":call AutoSetFileHead()"
function! AutoSetFileHead()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1, "\#!/bin/bash")
    endif

    "如果文件类型为python
    if &filetype == 'python'
        call setline(1, "\#!/usr/bin/env python")
        call append(1, "\# encoding: utf-8")
    endif

    if &filetype == 'cpp'
        call setline(1, "#include <iostream>")
        call append(1, "using namespace std;")
    endif
    normal G
    normal o
    normal o
endfunc

if has("autocmd")
    au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif


" 设置可以高亮的关键字
if has("autocmd")
  " Highlight TODO, FIXME, NOTE, etc.
  if v:version > 701
    autocmd Syntax * call matchadd('Todo',  '\W\zs\(TODO\|FIXME\|CHANGED\|DONE\|XXX\|BUG\|HACK\)')
    autocmd Syntax * call matchadd('Debug', '\W\zs\(NOTE\|INFO\|IDEA\|NOTICE\)')
  endif
endif


" plugin settings

" nerdtree nerdtreetabs {{{
    map <leader>n :NERDTreeToggle<CR>
    let NERDTreeHighlightCursorline=1
    let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$'  ]
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
    let g:NERDTreeMapOpenSplit = 's'
    let g:NERDTreeMapOpenVSplit = 'v'
"}}}

" solarized {{{
    let g:solarized_termtrans=1
    let g:solarized_contrast="normal"
    let g:solarized_visibility="normal"
"}}}


" Rainbow
let g:rainbow_active = 1

" pymode_folding
" let g:pymode_folding = 0

" pymode_virtualenv
" let g:pymode_virtualenv = 0

" syntastic {{{
    set statusline+=%#warningmsg#
    set statusline+=%{SyntasticStatuslineFlag()}
    set statusline+=%*
    let python_highlight_all = 1
    let g:syntastic_error_symbol='>>'
    let g:syntastic_warning_symbol='>'
    let g:syntastic_check_on_open=1
    let g:syntastic_check_on_wq=0
    let g:syntastic_enable_highlighting=1
    let g:syntastic_python_checkers=['pyflakes', 'pep8']
    let g:syntastic_python_pep8_args='--ignore=E501,E225,E124,E712'
" }}}

" ctrlp ctrlpfunky{{{
    nnoremap <Leader>\ :CtrlPFunky<Cr>
    let g:ctrlp_funky_matchtype = 'path'
    map <leader>f :CtrlPMRU<CR>
    let g:ctrlp_custom_ignore = {
        \ 'dir':  '\v[\/]\.(git|hg|svn|rvm)$',
        \ 'file': '\v\.(exe|so|dll|zip|tar|tar.gz|pyc)$',
        \ }
    let g:ctrlp_working_path_mode=0
    let g:ctrlp_match_window_bottom=1
    let g:ctrlp_max_height=15
    let g:ctrlp_match_window_reversed=0
    let g:ctrlp_mruf_max=500
    let g:ctrlp_follow_symlinks=1
    nnoremap <Leader>fu :CtrlPFunky<Cr>
    " narrow the list down with a word under cursor
    nnoremap <Leader>fU :execute 'CtrlPFunky ' . expand('<cword>')<Cr>
    let g:ctrlp_funky_syntax_highlight = 1

    let g:ctrlp_extensions = ['funky']
" }}}

" YouCompleteMe {{{
    let g:ycm_autoclose_preview_window_after_completion = 1
    let g:ycm_key_list_select_completion = ["<TAB>", "<Down>"]
    let g:ycm_key_list_previous_completion = ["<S-TAB>", "Up"]
    let g:ycm_complete_in_comments = 1
    let g:ycm_complete_in_strings = 1
    let g:ycm_use_ultisnips_completer = 1
    let g:ycm_collect_identifiers_from_comments_and_strings = 1
    let g:ycm_collect_identifiers_from_tags_files = 1
    let g:ycm_seed_identifiers_with_syntax=1
    if has("unix")
        let s:uname = system("uname -s")
        if s:uname == "Darwin\n"
            " mean MacOs
            let g:ycm_server_python_interpreter="/usr/bin/python"
        else
            let g:ycm_server_python_interpreter="/usr/bin/python"
        endif
    endif
    if !empty(glob("~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"))
    let g:ycm_global_ycm_extra_conf = "~/.vim/bundle/YouCompleteMe/third_party/ycmd/cpp/ycm/.ycm_extra_conf.py"
    endif
" }}}

" nerdtree nerdtreetabs {{{
    map <leader>n :NERDTreeToggle<CR>
    let NERDTreeHighlightCursorline=1
    let NERDTreeIgnore=[ '\.pyc$', '\.pyo$', '\.obj$', '\.o$', '\.so$', '\.egg$', '^\.git$', '^\.svn$', '^\.hg$'  ]
    autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | end
    let g:NERDTreeMapOpenSplit = 's'
    let g:NERDTreeMapOpenVSplit = 'v'
"}}}

" {{{ ag.vim
if executable('ag')
    " Use ag over grep
    set grepprg=ag\ --nogroup\ --nocolor
    " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
    let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

    " ag is fast enough that CtrlP doesn't need to cache
    let g:ctrlp_use_caching = 0
endif
" }}}

"" theme主题
set background=dark
set t_Co=256

"colorscheme desert
colorscheme solarized

" 设置标记一列的背景颜色和数字一行颜色一致
hi! link SignColumn   LineNr
hi! link ShowMarksHLl DiffAdd
hi! link ShowMarksHLu DiffChange

" for error highlight，防止错误整行标红导致看不清
highlight clear SpellBad
highlight SpellBad term=standout ctermfg=1 term=underline cterm=underline
highlight clear SpellCap
highlight SpellCap term=underline cterm=underline
highlight clear SpellRare
highlight SpellRare term=underline cterm=underline
highlight clear SpellLocal
highlight SpellLocal term=underline cterm=underline
