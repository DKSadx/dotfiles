" Programs required: ripgrep, bat, lazygit, node
" Plugins
call plug#begin('~/.vim/plugged')
Plug 'junegunn/vim-easy-align'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'scrooloose/nerdcommenter'
Plug 'jiangmiao/auto-pairs'
Plug 'ap/vim-buftabline'
Plug 'ekalinin/Dockerfile.vim'
Plug 'chrisbra/Colorizer'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Used together with fzf to append flag to Rg and Ag
Plug 'jesseleite/vim-agriculture'
" Removes highlight when you move the cursor
Plug 'jesseleite/vim-noh'
" Nerd font has to be installed and used for vim-devicons to work
Plug 'ryanoasis/vim-devicons'
Plug 'voldikss/vim-floaterm'
Plug 'Glench/Vim-Jinja2-Syntax'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'Rigellute/rigel'
Plug 'itchyny/lightline.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
call plug#end()

" Turns on spellcheck
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
nnoremap ' :FloatermNew --height=0.8 --width=0.8<CR>

" Opens lazygit in floating terminal
nnoremap <silent> <C-g> :FloatermNew --height=1.0 --width=1.0 lazygit<CR>

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
"map <C-g> :Gdiff<CR>

" Multiple cursors
let g:multi_cursor_start_word_key = '<C-n>'

" Set Leader to Space
let mapleader = "\<Space>"

" Toggles comment with Ctrl+/ NOT _, vim for some reason registers <C-/> as
" <C-_>
map <C-_> <plug>NERDCommenterToggle

" Maps leader(space) to be same as leader-w
map <Leader> <Plug>(easymotion-w)

" Uncomment the following to have Vim jump to the last position when                                                       
" reopening a file
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$")
    \| exe "normal! g`\"" | endif
endif

" Open split temp in new tab
nnoremap <C-e> :tabedit %<CR>

" Buffer bindings (ctrl+j/k)
set hidden
" Next buffer
nnoremap <C-j> :bnext<CR>
" Previous buffer
nnoremap <C-k> :bprev<CR>
" Close buffer
nnoremap <C-x> :bd<CR>

" ============================= "
" ============ Fzf ============ "
" ============================= "
" Open fzf finder with ;
map ; :Files<CR>
" This requires vim-agriculture plugin (appends flags)
nnoremap <C-f> :RgRaw -i 
nnoremap <C-b> :Buffers<CR>
" Always enable preview window on the right with 60% width
let g:fzf_preview_window = 'right:50%'
let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-h': 'split',
  \ 'ctrl-v': 'vsplit' }


" ============================= "
" ============ CoC ============ "
" ============================= "
" CoC stuff
" LSC used:
"   1. Go: CocInstall coc-go
"   2. Yaml: CocInstall coc-yaml (https://octetz.com/docs/2020/2020-01-06-vim-k8s-yaml-support/)
"     - Configuring Kuberneres coc:
"       I. :CocConfig
"       II. Paste this:
"       {
"         "yaml.schemas": {
"         "kubernetes": "/*.yaml"
"         }
"       }

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
"nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
"nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
"inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
"inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
"if has('nvim')
  "vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  "vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
"endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

" ============================= "
" ============================= "

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
