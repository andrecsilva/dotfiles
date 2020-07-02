"backspace fix
set backspace=2

"General improvements
set ic
set smartcase
set hls
set number
set hidden
set switchbuf=useopen
set completeopt=menuone,noinsert,noselect

set wildmenu

set foldmethod=indent
set nofoldenable

"TODO bad default
set path+=**,./

"Set wd to the file directory
"set autochdir

"filetype plugin indent on
"syntax on

nnoremap <Space> <Nop>
let mapleader = "\<Space>"
let maplocalleader = "\\"

"fzf
set rtp+=~/.fzf

packadd termdebug

"Plugins
call plug#begin('~/.vim/bundle')

"Visual 
"Colors
Plug 'jacoborus/tender.vim'
Plug 'morhetz/gruvbox'
Plug 'https://gitlab.com/protesilaos/tempus-themes-vim.git'
"Airline
"Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'

"Tags
"Plug 'ludovicchabant/vim-gutentags'

"Async Make
Plug 'neomake/neomake'

"Python
Plug 'davidhalter/jedi-vim', {'for':'python'} 
"Plug 'numirias/semshi'
"
"C++
"Plug 'jeaye/color_coded'
Plug 'octol/vim-cpp-enhanced-highlight'

"Tmux
Plug 'jpalardy/vim-slime'

"general tools
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf.vim'
Plug 'christoomey/vim-tmux-navigator'

"Latex
Plug 'lervag/vimtex', {'for':'tex'}
"Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'} " for VimPlug
Plug 'andrecsilva/iso4abbreviation', {'for':'bib'}

"spelling and grammar
"Plug 'rhysd/vim-grammarous'
Plug 'mateusbraga/vim-spell-pt-br'
"Plug 'inkarkat/vim-ingo-library.git'
"Plug 'inkarkat/vim-SpellCheck'

call plug#end()

"For vimtex
let g:vimtex_quickfix_mode=0
let g:vimtex_view_method='zathura'

set background=dark
"colorscheme kalisi
"let g:gruvbox_italic=1
"let g:gruvbox_guisp_fallback = "bg"
"colorscheme wombat256mod
colorscheme tempus_warp
set termguicolors
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

"Python configuration
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_python_ipython = 1

let g:neomake_python_pylint_maker = {'args': ['--disable=invalid-name,fixme,missing-function-docstring']}
let g:neomake_python_enabled_makers = ['pylint']

let g:jedi#usages_command = "<leader>u"

"C++,
"avoid complete searching through includes
autocmd Filetype cpp set complete=.,w,b,u,t
"pair angle brackets for templates
autocmd Filetype cpp set matchpairs+=<:>
"man pages
autocmd Filetype cpp set keywordprg=cppman

"fixes different color on text and nontext background
set t_ut=

"small script to send commands to a given tmuxpane
let g:TmuxLastCommand=''
let g:TmuxRunPane=-1

function! TmuxRunCommand(...)
	if a:0>0
		let g:TmuxLastCommand = escape(a:1, ' ')
		if a:0>1
			let g:TmuxRunPane = a:2
		endif
	endif
	if(g:TmuxLastCommand =='')
		echoerr 'No command given'
		return 
	endif
	if(g:TmuxRunPane ==-1)
		echoerr 'No pane specified'
		return
	endif
	call system('tmux send-keys -t ' .g:TmuxRunPane.' '.g:TmuxLastCommand.' '.'C-m')
endfunction
	
command! -nargs=* TmuxRunCommand :call TmuxRunCommand(<f-args>)
"endscript 

"Programming maps
map <leader>m :Neomake!<CR>
map <leader>l :Neomake<CR>
map <leader>r :TmuxRunCommand<CR>
map <leader>n :lnext<CR>
map <leader>p :lprevious<CR>
map <leader>g :execute "lvimgrep! /" . expand("<cword>") . "/ **"<CR>
