colorscheme peachpuff
syntax on
set bs=2
set ts=2
set sw=4
set nu
set ru
set ai
set is
set hls
set cin
set t_Co=256
set expandtab
set shiftwidth=2
set laststatus=2
set statusline=%5*%{getcwd()}
set statusline+=\ %2*%<%f%m
set statusline+=\ %1*\[%{&ff}:%{&fenc}:%Y]
set statusline+=\ \ \%3*[%{strftime('%Y/%b/%d\ %a\ %I:%M\ %p')}\]\ %5*%=\ Line:%4*%l\/%L\ %5*Column:%4*%c%V\ %5*%P
highlight User1 ctermfg=red
highlight User2 ctermfg=green
highlight User3 ctermfg=yellow
highlight User4 ctermfg=white
highlight User5 ctermfg=cyan

set nocompatible              " be iMproved, required
filetype off                  " required

let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }
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

	" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line


map e :Tex<CR>
map <F11> gT
map <F12> gt
map <F2> :set nu!<CR>
map <F3> :w<CR>:EXE 
command -nargs=* EXE execute CP_R() . <q-args>

function CP_R()
	if( &ft == 'cpp')
		let cpl = 'g++ -w -o "%:r.exe" -std=c++11 "%"' |
		let exc = '"./%:r.exe"'
	elseif( &ft == 'c')
		let cpl = 'gcc -w -o "%:r" -std=c99 "%"' |
		let exc = '"./%:r.exe"'
	elseif( &ft == 'java')
		let cpl = 'javac "%"' |
		let exc = 'java "%:r"'
	elseif( &ft == 'python')
		let exc = 'python "%"'
	elseif( &ft == 'sh')
		let exc = 'sh "%"'
	elseif( &ft == 'verilog')
		let cpl = 'iverilog "%" -o "%:r.exe"' |
		let exc = '"./%:r.exe"'
  elseif( &ft == 'ruby')
    let exc = 'ruby "%"'
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
	return '!clear;' . cp_r . ''
endfunction

