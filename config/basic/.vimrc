colorscheme peachpuff
syntax on
set bs=2
set ts=4
set softtabstop=4
set sw=4
set nu
set ru
set ai
set is
set hls
set cin
set ignorecase
set smartcase
set t_Co=256
set expandtab
set switchbuf+=newtab
set fileencodings=utf-8,big5
set fileformats=unix,dos
set clipboard=unnamedplus
set autoread
set mouse=a
au CursorHold * checktime
autocmd FileType html,css,javascript,ruby set ts=2 | set softtabstop=2 | set sw=2

set textwidth=999
let &colorcolumn="+".join(range(1, 999), ",+")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

" match ErrorMsg '\%>80v.\+'

set cursorline
hi CursorLine cterm=bold
hi Visual ctermbg=0
" hi Comment ctermfg=20
" hi Directory ctermfg=20

" status bar
highlight User1 ctermfg=red cterm=underline
highlight User2 ctermfg=green cterm=underline
highlight User3 ctermfg=yellow cterm=underline
highlight User4 ctermfg=white cterm=underline
highlight User5 ctermfg=cyan cterm=underline
set laststatus=2
set statusline=%5*%<%{CurDir()}/
set statusline+=\ %3*%f%m
set statusline+=\ %1*\[%{&fenc}:%Y]  
set statusline+=\ %5*%=\Line:%4*%l\/%L\ %5*Column:%4*%c%V\  

map e :Tex<CR>
map f :Ag! <cword><CR>
map <C-f> :Ag! 
map <F2> :wa<CR>:RUN 
map <F3> :wa<CR>:CPR 
map <F4> :NERDTreeToggle<CR>
map <F5> :set paste!<CR>
map <F6> :set nonu<CR>:GitGutterSignsDisable<CR>:IndentLinesDisable<CR>
map <F7> :set nu<CR>:GitGutterSignsEnable<CR>:IndentLinesEnable<CR>
map <F8> :set textwidth=
map <F9> :-tabmove<CR>
map <F10> :+tabmove<CR>
map <F11> gT
map <F12> gt
imap <F5> <ESC><F5>a
cnoremap w!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!<CR>
command -nargs=* RUN execute CPR('RUN') . <q-args> . '; echo "\e[1;31m[Terminated] $(date)\e[0m\a"'
command -nargs=* CPR execute CPR('CPR') . <q-args> . '; echo "\e[1;31m[Terminated] $(date)\e[0m\a"'


" vim plug
call plug#begin('~/.vim/plugged')
Plug 'othree/vim-autocomplpop'
Plug 'eparreno/vim-l9'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'rking/ag.vim'
Plug 'othree/yajs.vim'
Plug 'mattn/emmet-vim'
Plug 'airblade/vim-gitgutter'
Plug 'Raimondi/delimitMate'
Plug 'garbas/vim-snipmate'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'honza/vim-snippets'
Plug 'scrooloose/nerdtree'
Plug 'Yggdroot/indentLine'
call plug#end()

" ctrlp
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = {
            \ 'dir':  '\v[\/]\.(git|hg|svn)$',
            \ 'file': '\v\.(exe|so|dll)$',
            \ 'link': 'some_bad_symbolic_links',
            \ }

" emmet
let g:user_emmet_expandabbr_key = '<C-e>'
"autocmd Filetype html,css,javascript imap <expr><tab>
"  \ emmet#isExpandable() ? '<C-e>' :
"  \ '<tab>'

" delimitMate
autocmd Filetype python let b:delimitMate_nesting_quotes = ['"']
autocmd Filetype python let b:delimitMate_nesting_quotes = ["'"]

" YouCompleteMe
let g:ycm_python_binary_path = 'python'

" NERDTree
" let g:NERDTreeWinPos = "right"
let g:NERDTreeShowHidden = 1
let g:NERDTreeQuitOnOpen=1

" Intent line
let g:indentLine_color_term = 235
let g:indentLine_char = '|'

function! MouseToggle()
    if &mouse == 'a'
        set mouse=
    else
        set mouse=a
    endif
endfunction

function! CurDir()
    let curdir = substitute(getcwd(), $HOME, '~', '')
    return curdir
endfunction

function CPR(flag)
    if filereadable('makefile') || filereadable('Makefile')
        let cpl = ''
        let exc = 'make'
    elseif( &ft == 'cpp')
        let cpl = 'g++ -o %:r -std=c++14 -Wall -Wextra -pedantic % && ' |
        let exc = './%:r'
    elseif( &ft == 'c')
        let cpl = 'gcc -o %:r -Wall -Wextra -pedantic % && ' |
        let exc = './%:r'
    elseif( &ft == 'java')
        let cpl = 'javac % && ' |
        let exc = 'java %:r'
    elseif( getline(1) =~ 'python3')
        let exc = 'python3 %'
    elseif( getline(1) =~ 'python2')
        let exc = 'python2 %'
    elseif( &ft == 'python')
        let exc = 'python %'
    elseif( getline(1) =~ 'bash')
        let exc = 'bash %'
    elseif( getline(1) =~ 'zsh')
        let exc = 'zsh %'
    elseif( &ft == 'sh')
        let exc = 'sh %'
    elseif( &ft == 'verilog')
        let cpl = 'iverilog % -o %:r.exe && ' |
        let exc = './%:r.exe'
    elseif( &ft == 'ruby')
        let exc = 'ruby %'
    elseif( &ft == 'tex')
        let cpl = 'pdflatex % && ' |
        let exc = ''
    else
        let exc = './%'
    endif

    if a:flag == 'CPR'
        if !exists('cpl')
            echo 'Can''t compile this filetype ...'
            return
        else
            let cp_r = 'echo "\e[1;33m[Compiling] $(date)\e[0m" && ' . cpl . 'echo "\e[1;32m[Running] $(date)\e[0m" && time ' . exc
        endif
    else 
        if !exists('exc')
            echo 'Can''t run this filetype ...'
            return
        else
            let cp_r = 'echo "\e[1;32m[Running] $(date)\e[0m" && time ' . exc
        endif
    endif

    return '!clear;' . cp_r . ' '
endfunction
