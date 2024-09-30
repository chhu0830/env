colorscheme peachpuff
syntax on
set encoding=utf-8
set updatetime=100
set mouse=a
set number
set ruler
set ignorecase
set smartcase
set incsearch
set hlsearch
set splitbelow

set autoindent
set cindent
set smartindent
set expandtab 
set backspace=2
set shiftwidth=4
set softtabstop=4
set tabstop=4
" set textwidth=79
autocmd FileType html,css,javascript,typescript,typescriptreact,ruby set ts=2 sts=2 sw=2
autocmd FileType markdown,yaml,xml,vim,sh,zsh set ts=2 sts=2 sw=2
autocmd FileType go set noexpandtab

set foldmethod=syntax
" set nofoldenable
set foldlevel=999
set foldtext=repeat('\ ',indent(v:foldstart)).trim(getline(v:foldstart)).'\ ...('.(v:foldend-v:foldstart+1).')\ '.trim(getline(v:foldend)).'\ '
highlight Folded ctermfg=cyan ctermbg=0

highlight Visual ctermbg=0
" highlight Comment ctermfg=20
" highlight Directory ctermfg=20

highlight CursorLine cterm=bold
highlight CursorLineNR cterm=bold
set cursorline

highlight SignColumn guibg=#000000 ctermbg=0
set signcolumn=yes

highlight ColorColumn ctermbg=235 guibg=#2c2d27
let &colorcolumn='72,80'

highlight User1 ctermfg=red
highlight User2 ctermfg=yellow
highlight User3 ctermfg=green
highlight User4 ctermfg=cyan
highlight User5 ctermfg=white
set laststatus=2
set statusline=%5*📁%<%{CurDir()}/ 
set statusline+=\ 📝%2*%f%m
set statusline+=%1*\ (%{&fenc}:%Y)\ %4*
" set statusline+=%=\ 🔎\ Ln\ %l/%L\ (%p%%)\,\ Col\ %c%5*
set statusline+=%=\ 🔖\ %l:%c\|%L(%p%%)%5*


""" vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | call ExtraPlugInstall() | source ${MYVIMRC} | endif

call plug#begin('~/.vim/plugged')
Plug 'airblade/vim-gitgutter'
Plug 'jiangmiao/auto-pairs'
Plug 'ycm-core/YouCompleteMe'
Plug 'preservim/nerdcommenter'
Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'zivyangll/git-blame.vim'
call plug#end()

""" airblade/vim-gitgutter
let g:gitgutter_map_keys = 0
highlight GitGutterAdd    guifg=#009900 ctermfg=2
highlight GitGutterChange guifg=#bbbb00 ctermfg=3
highlight GitGutterDelete guifg=#ff2222 ctermfg=1


""" jiangmiao/auto-pairs
let g:AutoPairsShortcutFastWrap = '<S-tab>'
" let g:AutoPairsMapBS = 0
" let g:AutoPairsFlyMode = 1
" autocmd FileType html let b:AutoPairs = AutoPairsDefine({'<!--':'-->', '<':'>'}, ['{'])
autocmd FileType php let b:AutoPairs = AutoPairsDefine({'<?':'?>', '<?php': '?>'})

""" ycm-core/YouCompleteMe
set completeopt-=preview
" let g:ycm_autoclose_preview_window_after_completion = 1
" let g:ycm_autoclose_preview_window_after_insertion = 1
" let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/.ycm_extra_conf.py'
" let g:ycm_goto_buffer_command = 'new-tab'
let g:ycm_goto_buffer_command = 'split-or-existing-window'

""" preservim/nerdcommenter
" vim register <C-/> as <C-_>
map <C-_> <leader>c<space>
" Create default mappings
let g:NERDCreateDefaultMappings = 1
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not
let g:NERDToggleCheckAllLines = 1

""" kien/ctrlp.vim
let g:ctrlp_working_path_mode = 'ra'
" let g:ctrlp_regexp = 1
let g:ctrlp_show_hidden = 1
let g:ctrlp_custom_ignore = {'dir': '\.git$\|node_modules$'}

""" mattn/emmet-vim
" let g:user_emmet_leader_key='<C-e>'
let g:user_emmet_expandabbr_key = '<C-e>'

""" zivyangll/git-blame.vim

set switchbuf+=usetab,newtab,uselast
" autocmd BufLeave * cclose
autocmd FileType qf nnoremap <buffer> <C-t> <C-w><Enter>:cclose<CR><C-w>T
autocmd FileType qf nnoremap <buffer> t <C-w><Enter><C-w>TgT<C-w><C-w>

nnoremap <C-g> :tab YcmCompleter GoTo<CR>
nnoremap fd :tab YcmCompleter GoTo<CR>
nnoremap fD :YcmCompleter GoTo<CR>
nnoremap fx :YcmCompleter GoToCallers<CR>
map fw :FIND<CR>
nnoremap <C-f> :SEARCH 

nnoremap gb :<C-u>call gitblame#echo()<CR>
" git conflict
map gc /<<<<<<<\\|=======\\|>>>>>>><CR>
map gw :GitGutterDiffOrig<CR><C-w>w
map gW :GITCOMP<CR>

map <tab> za
map <S-tab><S-tab> zM
map <S-tab><tab> zR

map <F2> :wa<CR>:EXEC 
map <F3> :call CopyPasteToggle()<CR>
map <F4> :wa<CR>:COMMIT 
map <F5> :checktime<CR> \| :GitGutterAll<CR> \| :YcmRestartServer<CR>
map <F7> :YCMInstall 
map <F8> :MARK 
map <F9> :-tabmove<CR>
map <F10> :+tabmove<CR>
map <F11> gT
map <F12> gt
imap <F3> <ESC><F3>a
imap <F9> <ESC><F9>a
imap <F10> <ESC><F10>a
imap <F11> <ESC><F11>
imap <F12> <ESC><F12>

command -nargs=* EXEC execute EXEC(<q-args>)
command -nargs=* MARK execute MARK(<q-args>)
command -nargs=* COMMIT execute 'silent tabdo windo !git add %' | execute '!clear; git commit -m "' . <q-args> . '"' | execute 'silent tabdo windo w'
command -nargs=* SEARCH execute 'vimgrep /' . <q-args> . '/j **/*' | execute 'copen'
command -nargs=* FIND execute 'vimgrep /' . expand('<cword>') . '/j **/*' | execute 'copen'
command -nargs=* YCMInstall execute '!/usr/bin/python3 ~/.vim/plugged/YouCompleteMe/install.py ' . <q-args>
command -nargs=* GITCOMP execute 'let gitgutter_diff_base="' . inputdialog("Base: ") . '"' | execute 'GitGutterDiffOrig' | execute 'wincmd w' | execute 'let gitgutter_diff_base=""'


function CopyPasteToggle()
  if &nu == 1
    set nonumber
    set paste
    set signcolumn=no
  else
    set number
    set nopaste
    set signcolumn=yes
  endif
endfunction

function! CurDir()
  let curdir = substitute(getcwd(), $HOME, '~', '')
  return curdir
endfunction

function EXEC(args)
  let cpl = ''
  if filereadable('.vimexc')
    let exc = './.vimexc %'
  elseif filereadable('makefile') || filereadable('Makefile')
    let exc = 'make'
  elseif( &ft == 'cpp')
    let cpl = 'g++ -o %:r -std=c++14 -Wall -Wextra -pedantic %' |
    let exc = './%:r'
  elseif( &ft == 'c')
    let cpl = 'gcc -o %:r -Wall -Wextra -pedantic %' |
    let exc = './%:r'
  elseif( &ft == 'java')
    let cpl = 'javac %' |
    let exc = 'java %:r'
  elseif( &ft == 'go' )
    let exc = 'go run %'
    " let cpl = 'go build %' |
    " let exc = './%:r'
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
    let cpl = 'iverilog % -o %:r.exe' |
    let exc = './%:r.exe'
  elseif( &ft == 'ruby')
    let exc = 'ruby %'
  elseif( &ft == 'tex')
    let cpl = 'pdflatex % && ' |
    let exc = ''
  else
    let exc = './%'
  endif

  if !exists('exc')
    echo 'Can''t run this filetype ...'
    return
  else
    if cpl != ''
      let cp_r = 'echo -e "\e[1;33m[Compiling] $(date)\e[0m" && ' . cpl . ' && echo -e "\e[1;32m[Running] $(date)\e[0m" && time ' . exc
    else
      let cp_r = 'echo -e "\e[1;32m[Running] $(date)\e[0m" && time ' . exc
    endif
  endif

  return '!clear;' . cp_r . ' ' . a:args . '; echo -e "\e[1;31m[Terminated][$?] $(date)\e[0m\a"'
endfunction

function ExtraPlugInstall()
  if !empty(glob('~/.vim/plugged/YouCompleteMe/install.py'))
    if empty(glob('~/.vim/plugged/YouCompleteMe/third_party/ycmd/ycm_core.cpython-38-x86_64-linux-gnu.so'))
      silent !echo '=== Install YouCompleteMe Prerequisite ==='
      silent !sudo apt install -y build-essential cmake vim-nox python3-dev
      silent !python3 ~/.vim/plugged/YouCompleteMe/install.py --quiet
      " silent !sudo apt install -y mono-complete golang nodejs default-jdk npm
      " silent !python3 ~/.vim/plugged/YouCompleteMe/install.py --all --quiet
    endif
  endif
endfunction

function MARK(cols)
  let clist = split(a:cols, ' ') 
  if len(clist) == 0
    let &colorcolumn='999'
  else
    for col in clist
      let &colorcolumn=col . ',' . &colorcolumn
    endfor
  endif
endfunction
