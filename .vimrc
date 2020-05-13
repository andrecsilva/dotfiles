"backspace fix
set backspace=2

"General improvements
set ic
set smartcase
set hls
set number

set wildmenu

"Set wd to the file directory
"set autochdir

"For airline
"set laststatus=2 
"let g:airline_powerline_fonts = 1

filetype plugin indent on
syntax on

nnoremap <Space> <Nop>
let mapleader = "\<Space>"
let maplocalleader = "\\"

"fzf
set rtp+=~/.fzf

"Plugins
call plug#begin('~/.vim/bundle')

"Visual 
"Colors
Plug 'https://github.com/altercation/vim-colors-solarized.git'
Plug 'jacoborus/tender.vim'
Plug 'freeo/vim-kalisi'
Plug 'sonph/onehalf',{'rtp': 'vim/'}
Plug 'morhetz/gruvbox'
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

"Tmux
Plug 'jpalardy/vim-slime'
"Plug 'benmills/vimux'

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

"colorscheme onehalfdark
set background=dark
"colorscheme kalisi
let g:gruvbox_italic=1
let g:gruvbox_guisp_fallback = "bg"
colorscheme gruvbox
"let g_airline_theme='papercolor'

"Python configuration
let g:slime_target = "tmux"
let g:slime_default_config = {"socket_name": "default", "target_pane": "{right-of}"}
let g:slime_python_ipython = 1

let g:neomake_python_pylint_maker = {'args': ['--disable=invalid-name,fixme,missing-function-docstring']}
let g:neomake_python_enabled_makers = ['pylint']

let g:jedi#usages_command = "<leader>u"

"C++, avoid auto/omnicomplete searching through includes
set complete=.,w,b,u,t

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
map <leader>r :TmuxRunCommand
map <leader>n :lnext<CR>
map <leader>p :lprevious<CR>
