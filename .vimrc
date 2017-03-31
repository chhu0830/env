colorscheme peachpuff
syntax on
set bs=2
set ts=2
set sw=2
set nu
set ru
set ai
set is
set hls
set cin
set t_Co=256
set expandtab

" c++ syntax checking
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 '

let g:syntastic_python_checkers = ['python3']


" emmet
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set fileencodings=utf8,big5,gbk,latin1
map <C-u> :set fileencoding=utf8<CR>
map <C-g> :set fileencoding=big5<CR>

set cursorline
hi CursorLine cterm=bold ctermbg=8
hi Visual ctermbg=0

set laststatus=2
set statusline=%5*%{hostname()}:%<%{CurDir()}/
set statusline+=\ %2*%f%m
set statusline+=\ %1*\[%{&fenc}:%Y]	
set statusline+=\ %5*%=\Line:%4*%l\/%L\ %5*Column:%4*%c%V\  
function! CurDir()
	" let curdir = substitute(getcwd(), $HOME, "~", "")
	let prefix = " ../"
	let curdir = prefix . fnamemodify(getcwd(), ':t')
	return curdir
endfunction
highlight User1 ctermfg=red cterm=underline
highlight User2 ctermfg=green cterm=underline
highlight User3 ctermfg=yellow cterm=underline
highlight User4 ctermfg=white cterm=underline
highlight User5 ctermfg=cyan cterm=underline

set nocompatible							" be iMproved, required
filetype off									" required

let g:ag_working_path_mode="r"

let g:ctrlp_custom_ignore = {
	\ 'dir':	'\v[\/]\.(git|hg|svn)$',
	\ 'file': '\v\.(exe|so|dll)$',
	\ }
let g:ctrlp_working_path_mode = 0
let g:netrw_liststyle=3
let g:ycm_global_ycm_extra_conf = "~/.vim/.ycm_extra_conf.py"
let g:ycm_key_list_select_completion=[]
let g:ycm_key_list_previous_completion=[]

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
	" alternatively, pass a path where Vundle should install plugins
	"call vundle#begin('~/some/path/here')

	" let Vundle manage Vundle, required
	Plugin 'VundleVim/Vundle.vim'

	" The following are examples of different formats supported.
	" Keep Plugin commands between vundle#begin/end.
	" plugin on GitHub repo
	Plugin 'tpope/vim-fugitive'
	" plugin from http://vim-scripts.org/vim/scripts.html
	Plugin 'L9'
	Plugin 'https://github.com/ctrlpvim/ctrlp.vim.git'
	Plugin 'https://github.com/honza/vim-snippets'
	Plugin 'https://github.com/othree/vim-autocomplpop'
	Plugin 'https://github.com/marcweber/vim-addon-mw-utils'
	Plugin 'https://github.com/tomtom/tlib_vim'
	Plugin 'https://github.com/garbas/vim-snipmate'
	Plugin 'Raimondi/delimitMate'
	Plugin 'airblade/vim-gitgutter'
	Plugin 'https://github.com/rking/ag.vim'
	" Plugin 'https://github.com/vim-syntastic/syntastic.git'
	Plugin 'http://github.com/mattn/emmet-vim/'

	" All of your Plugins must be added before the following line
call vundle#end()						" required
filetype plugin indent on		" required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList			 - lists configured plugins
" :PluginInstall		- installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean			- confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

:set switchbuf+=newtab

map e :Tex<CR>
map <F11> gT
map <F12> gt
map <F2> :set nu!<CR>
" map <F2> :tabnew<CR>:AG 
map <F3> :w<CR>:EXE 
map <F4> :execute "vimgrep /" .expand("<cword>") . "/j **" <Bar> cw<CR>
command -nargs=* EXE execute CP_R() . <q-args>
" command -nargs=* AG vimgrep <q-args> * | copen

function CP_R()
	if filereadable("makefile") || filereadable("Makefile")
		let exc = 'make'
	elseif( &ft == 'cpp')
		let cpl = 'g++ -w -o "%:r.out" -std=c++11 "%"' |
		let exc = '"./%:r.out"'
	elseif( &ft == 'c')
		let cpl = 'gcc -w -o "%:r.out" -std=c99 "%"' |
		let exc = '"./%:r.out"'
	elseif( &ft == 'java')
		let cpl = 'javac "%"' |
		let exc = 'java "%:r"'
	elseif( &ft == 'python')
		let exc = 'python3 "%"'
	elseif( &ft == 'sh')
		let exc = 'sh "%"'
	elseif( &ft == 'verilog')
		let cpl = 'iverilog "%" -o "%:r.exe"' |
		let exc = '"./%:r.exe"'
	elseif( &ft == 'ruby')
		let exc = 'ruby "%"'
	elseif( &ft == 'tex')
		let exc = 'pdflatex "%"' 
    else
        let exc = './"%"'
	endif

	if !exists('exc')
		echo 'Can''t compile this filetype ...'
		return
	endif
	if exists('cpl')
		let cp_r = 'echo "[Compiling]"; ' . cpl . ' && echo "[Running]" && time ' . exc
	else
		let cp_r = 'echo "[Running]" && time ' . exc
	endif
	return '!clear;' . cp_r . ' '
endfunction

