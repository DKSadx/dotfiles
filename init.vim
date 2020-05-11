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
Plug 'Rigellute/rigel'
Plug 'itchyny/lightline.vim'
call plug#end()


" Set different cursors in different modes
let &t_SI = "\<Esc>[6 q"
let &t_SR = "\<Esc>[4 q"
let &t_EI = "\<Esc>[2 q"

" Sets keycode timeout
set timeoutlen=150 ttimeoutlen=0

" Turns hybrid line numbers on
set number relativenumber
set nu rnu

" Line number width
set numberwidth=2

" Git checks file every 100ms(default 4000ms)
set updatetime=100

" Case insensitive searche
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
" Gets rid of thing like --INSERT--
set noshowmode 
" Gets rid of display of last command
set noshowcmd  
" Gets rid of the file name displayed in the command line bar
set shortmess+=F  

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

" Maps S to save file
nnoremap S :update<CR>

" Maps q to exit file
nnoremap q :q<CR>

" Maps Q to force exit file
nnoremap Q :q!<CR>

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

" Enables moving lines with alt (for loop is needed to make urxvt work with
" the alt key)
for i in range(97,122)
  let c = nr2char(i)
  exec "map \e".c." <A-".c.">"
  exec "map! \e".c." <A-".c.">"
endfor
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Buffer bindings (ctrl+j/k)
set hidden
nnoremap <C-j> :bnext<CR>
nnoremap <C-k> :bprev<CR>


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
