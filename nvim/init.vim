" Plugins
call plug#begin('~/.vim/plugged')
Plug 'https://github.com/junegunn/vim-easy-align.git'
Plug 'https://github.com/easymotion/vim-easymotion.git'
Plug 'https://github.com/tpope/vim-surround.git'
Plug 'https://github.com/scrooloose/nerdtree.git'
Plug 'https://github.com/jiangmiao/auto-pairs.git'
Plug 'https://github.com/scrooloose/nerdcommenter.git'
Plug 'https://github.com/ap/vim-buftabline.git'
Plug 'https://github.com/ekalinin/Dockerfile.vim.git'
Plug 'https://github.com/tpope/vim-fugitive.git'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Nerd font has to be installed and used for vim-devicons to work
Plug 'ryanoasis/vim-devicons'
Plug 'voldikss/vim-floaterm'
"Plug 'vim-scripts/AutoComplPop'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
"Plug 'zxqfl/tabnine-vim'
Plug 'Rigellute/rigel'
Plug 'itchyny/lightline.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" Turn on spellcheck
"set spell

" Set different cursors in different modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Move on wrapped lines
" noremap j gj
" noremap k gk

" Sets keycode timeout
set timeoutlen=150 ttimeoutlen=0

" Turns hybrid line numbers on
set nu rnu

" Line number width
set numberwidth=2

" Git checks file every 100ms(default 4000ms)
set updatetime=100

" Case insensitive search
set ignorecase

" Persistent undo, undo works after closing file
set undofile

" Searches while typing
set incsearch

" Doesn't create swap files
set noswapfile

" Converts tabs to spaces
set expandtab

" The width of a TAB is set to 2. Still it is a \t. It is just that. Vim will interpret it to be having a width of 2.
set tabstop=2       

" Indents will have a width of 2
set shiftwidth=2

" Sets the number of columns for a TAB
set softtabstop=2   

" Gets rid of thing like --INSERT--
set noshowmode 

" Gets rid of display of last command
set noshowcmd  

" Gets rid of the file name displayed in the command line bar
set shortmess+=F  

" Remove SpellCap highlight
autocmd VimEnter * hi clear SpellCap

" Don't autocomment next line
autocmd FileType * set formatoptions-=cro

" Disables folding for markdown (vim-markdown plugin)
let g:vim_markdown_folding_disabled = 1

" --------------- Colors ------------------ "
" Colorscheme
syntax enable
colorscheme rigel

" Background color
hi Normal ctermbg=none

" Selected text color
hi Visual term=reverse cterm=reverse

" Current line colors
hi CursorLineNr  ctermbg=blue ctermfg=white

" Easymotion colors
hi EasyMotionTarget2First ctermbg=none ctermfg=191
hi EasyMotionTarget2Second ctermbg=none ctermfg=191
" hi EasyMotionTarget ctermbg=none ctermfg=red
" hi EasyMotionShade  ctermbg=none ctermfg=yellow

" Line number colors
hi LineNr ctermfg=blue ctermbg=0

" --------------- Bindings ------------------ "

" By pressing ctrl+r in visual mode, you will be prompted to enter text to replace with.
" Press enter and then confirm each change you agree with y or decline with n.
vnoremap <C-r> "hy:%s/<C-r>h//gc<left><left><left>

" Toggle line numbers (<bar> needs to be used if chaining multiple commands)
nnoremap <C-l> :set nu! <bar> :set rnu!<CR>

" Opens floating terminal with
nnoremap ; :FloatermNew --height=0.8 --width=0.8<CR>

" Remaps exit from nvim terminal to ,
tnoremap , <C-\><C-N>

" P doesn't override the deafult registrer
vnoremap p "_dP

" Maps Q to exit file
nnoremap Q :q<CR>

" Maps redo to U
nnoremap U :redo<CR>

" Yank to system clipboard(requires gvim on Arch linux)
map Y "+y

" Toggles nerdtree file explorer
map <C-o> :NERDTreeToggle<CR>

" Git diff
map <C-g> :Gdiff<CR>

" Multiple cursors
let g:multi_cursor_start_word_key = '<C-n>'

" Set Leader to Space
let mapleader = "\<Space>"

" Toggles comment with Ctrl+/ NOT _, vim for some reason registers <C-/> as
" <C-_>
map <C-_> <plug>NERDCommenterToggle

" Maps leader(space) to be same as leader-w
map <Leader> <Plug>(easymotion-w)

" Buffer bindings (ctrl+j/k)
set hidden
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprev<CR>
nnoremap <C-x> :bd<CR>

" ====== fzf ======
" Open fzf finder with ;
map ' :Files<CR>
" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:50%'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }

" ====== CoC ======
" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()


" Lightline configuration
set laststatus=2
let g:lightline = {
      \ 'colorscheme': 'deus',
      \ }

" Vim wiki configs
set nocompatible
filetype plugin on
"syntax on
nmap ww <Plug>VimwikiTabIndex

" Hides tmux bar when vim is open
"autocmd VimEnter,VimLeave * silent !tmux set status off

" === Extra notes ===
" <c-a> - increases next number
" <c-x> - decreases next numbers
