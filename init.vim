runtime! debian.vim

call plug#begin('~/.local/share/nvim/plugged')
Plug 'sainnhe/sonokai'
Plug 'terryma/vim-multiple-cursors'
Plug 'scrooloose/nerdtree'
" Plug 'sirver/ultisnips'
Plug 'kien/rainbow_parentheses.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'sheerun/vim-polyglot'
Plug 'dhruvasagar/vim-table-mode'
Plug 'liuchengxu/vista.vim'
Plug 'lervag/vimtex'
Plug 'vimwiki/vimwiki'
call plug#end()

" Color and syntax
if has('termguicolors')
	set termguicolors
endif
set nowrap

set nocompatible
filetype plugin on
syntax on

let g:sonokai_style = 'shusia'

color sonokai
set number
set relativenumber


" CoC.Nvim
" ============================================================
" ============================================================
" Use <c-space> to trigger completion.

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
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

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)


" Vimwiki
" ============================================================
" ============================================================
let g:vimwiki_list = [{'path': '/mnt/d/OneDrive/'}]


" Remaps
" ============================================================
" ============================================================
nnoremap Y y$
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
autocmd filetype python nnoremap <F5> :term ipython3 -i %<CR>
autocmd filetype fortran nnoremap <F5> :term gfortran -fdefault-real-8 -O3 % -lblas -llapack && ./a.out<CR>

" Vimtex 
" ============================================================
" ============================================================
let g:tex_flavor='latex'
let g:vimtex_view_general_viewer = 'texworks'
let g:vimtex_quickfix_mode=0
"set conceallevel=1

" Rainbow Parentheses
" ============================================================
" ============================================================
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
au Syntax * RainbowParenthesesLoadRound

" NERDtree
" ============================================================
" ============================================================
let g:NERDTreeWinSize=40

" Vista
" ============================================================
" ============================================================
nmap <F8> :Vista coc<CR>
let g:vista_sidebar_width = 40
let g:vista_icon_indent = [">", ""]
let g:vista#renderer#enable_icon = 0

" Templates
" ============================================================
" ============================================================
autocmd bufnewfile *.py 0r ~/.config/nvim/templates/template.py

