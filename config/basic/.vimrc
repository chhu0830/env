colorscheme peachpuff
syntax on
set bs=2
set ts=2
set softtabstop=2
set sw=2
set nu
set ru
set ai
set is
set hls
set cin
set ignorecase
set smartcase
set mouse=a
set t_Co=256
set expandtab
set switchbuf+=newtab
set fileencodings=utf-8,big5
set fileformats=unix,dos

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
set statusline+=\ %2*%f%m
set statusline+=\ %1*\[%{&fenc}:%Y]  
set statusline+=\ %5*%=\Line:%4*%l\/%L\ %5*Column:%4*%c%V\  
function! CurDir()
  let curdir = substitute(getcwd(), $HOME, '~', '')
  return curdir
endfunction

map e :Tex<CR>
map f :Ag! <cword><CR>
map <C-f> :Ag! 
map <F2> :w<CR>:RUN 
map <F3> :w<CR>:CPR 
map <F4> :NERDTreeToggle<CR>
map <F5> :call MouseToggle()<CR>:set paste!<CR>
map <F6> :call MouseToggle()<CR>:GitGutterSignsToggle<CR>:set nu!<CR>
map <F11> gT
map <F12> gt
imap <F5> <ESC><F5>a
cnoremap w!! execute 'silent! write !sudo tee % > /dev/null' <bar> edit!<CR>
command -nargs=* RUN execute CPR('RUN') . <q-args>
command -nargs=* CPR execute CPR('CPR') . <q-args>
function! MouseToggle()
  if &mouse == 'a'
    set mouse=
  else
    set mouse=a
  endif
endfunction


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

" YouCompleteMe
let g:ycm_python_binary_path = 'python'

" NERDTree
" let g:NERDTreeWinPos = "right"
let g:NERDTreeShowHidden = 1


function CPR(flag)
  if filereadable('makefile') || filereadable('Makefile')
    let exc = 'make'
  elseif( &ft == 'cpp')
    let cpl = 'g++ -w -o "%:r" -std=c++11 "%";' |
    let exc = '"./%:r"'
  elseif( &ft == 'c')
    let cpl = 'gcc -w -o "%:r" -std=c99 "%";' |
    let exc = '"./%:r"'
  elseif( &ft == 'java')
    let cpl = 'javac "%";' |
    let exc = 'java "%:r"'
  elseif( &ft == 'python')
    let exc = './"%"'
  elseif( &ft == 'sh')
    let exc = './"%"'
  elseif( &ft == 'verilog')
    let cpl = 'iverilog "%" -o "%:r.exe";' |
    let exc = '"./%:r.exe"'
  elseif( &ft == 'ruby')
    let exc = 'ruby "%"'
  elseif( &ft == 'tex')
    let cpl = 'pdflatex "%";' |
    let exc = 'xpdf "%:r.pdf"'
  else
    let exc = './"%"'
  endif

  if a:flag == "CPR"
    if !exists('cpl')
      echo 'Can''t compile this filetype ...'
      return
    else
      let cp_r = 'echo "[Compiling]"; ' . cpl . 'echo "[Running]" && time ' . exc
    endif
  else 
    if !exists('exc')
      echo 'Can''t run this filetype ...'
      return
    else
      let cp_r = 'echo "[Running]" && time ' . exc
    endif
  endif

  return '!clear;' . cp_r . ' '
endfunction
